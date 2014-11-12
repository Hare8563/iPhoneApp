//
//  imageViewController.m
//  Camera
//
//  Created by Tetsushi on 2014/11/12.
//  Copyright (c) 2014年 Kojima. All rights reserved.
//

#import "imageViewController.h"

@interface imageViewController ()



@property (nonatomic, strong) AVCaptureStillImageOutput *imageOutput;
@end

@implementation imageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //カメラデバイスの初期化
    AVCaptureDevice *camera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //入力の初期化
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:camera error:NULL];
    
    //セッションの初期化
    AVCaptureSession *captureSession = [[AVCaptureSession alloc] init];
    [captureSession addInput:deviceInput];
    [captureSession beginConfiguration];
    captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    [captureSession commitConfiguration];
    
    //プレビューの表示
    AVCaptureVideoPreviewLayer *prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
    prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    prevLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:prevLayer atIndex:0];
    
    self.imageOutput = [[AVCaptureStillImageOutput alloc] init];
    [captureSession addOutput:self.imageOutput];
    
    [captureSession startRunning];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


UIBarButtonItem *btn = nil;
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self dismissViewControllerAnimated:YES completion:nil];
    //デリゲートがメソッドに応答できるかチェックしてから呼び出す
    
    if ([self.delegate respondsToSelector:@selector(modalViewDidDissmissed:)])
    {
        [self.delegate modalViewDidDissmissed:btn.tag];
    }
    else
    {
        UIAlertView* alv = [[UIAlertView alloc] initWithTitle:@"Error" message:@"modalViewDidDissmissedが定義されてません" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alv show];
    }

}

-(IBAction)dissmissModal:(id)sender{
    //これは使わないので削除かコメント
    //[self dismissModalViewControllerAnimated:YES];
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        btn = (UIBarButtonItem*)sender;
    }
    
    if (btn.tag == 0) {
        AVCaptureConnection *connection = [[self.imageOutput connections] lastObject];
        
        
        // シャッター動作追加 ※取る前に動かしてるから非同期です。
        CATransition *shutterAnimation = [CATransition animation];
        [shutterAnimation setDelegate:self];
        // シャッター速度
        [shutterAnimation setDuration:0.5];
        shutterAnimation.timingFunction = UIViewAnimationCurveEaseInOut;
        [shutterAnimation setType:@"cameraIris"];
        [shutterAnimation setValue:@"cameraIris" forKey:@"cameraIris"];
        CALayer *cameraShutter = [[CALayer alloc]init];
        //    [cameraShutter setBounds:CGRectMake(0.0, 0.0, 320.0, 425.0)];
        [self.view.layer addSublayer:cameraShutter];
        [self.view.layer addAnimation:shutterAnimation forKey:@"cameraIris"];
        
        
        [self.imageOutput captureStillImageAsynchronouslyFromConnection:connection
                                                      completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
                                                          
                                                          NSData *data = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                                                          UIImage *image = [UIImage imageWithData:data];
                                                          ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
                                                          
                                                          [library writeImageToSavedPhotosAlbum:image.CGImage
                                                                                    orientation:image.imageOrientation
                                                                                completionBlock:^(NSURL *assetURL, NSError *error) {
                                                                                }];
                                                      }];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
        if ([self.delegate respondsToSelector:@selector(modalViewDidDissmissed:)])
        {
            [self.delegate modalViewDidDissmissed:btn.tag];
        }
        else
        {
            UIAlertView* alv = [[UIAlertView alloc] initWithTitle:@"Error" message:@"modalViewDidDissmissedが定義されてません" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
            [alv show];
        }

    }
  
}
@end
