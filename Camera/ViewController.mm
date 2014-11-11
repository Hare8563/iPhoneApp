//
//  ViewController.m
//  Camera
//
//  Created by hanasake on 2014/11/08.
//  Copyright (c) 2014年 Kojima. All rights reserved.
//

#import "ViewController.h"
#import <opencv2/highgui/ios.h>

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (strong, nonatomic) ALAssetsLibrary* library;
@end

@implementation ViewController

UIImage* defaultIMG;
BOOL grayflag=false;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showImagePicker:(id)sender {
    UIImagePickerControllerSourceType sourceType
    = UIImagePickerControllerSourceTypeCamera;
    
    if([UIImagePickerController isSourceTypeAvailable:sourceType]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = sourceType;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:NULL];
    }
}


- (void)imagePickerController :(UIImagePickerController *)picker
        didFinishPickingImage :(UIImage *)image editingInfo :(NSDictionary *)editingInfo {
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    self.library = [[ALAssetsLibrary alloc] init];
    
    
    [self.library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:
     ^(ALAssetsGroup *group, BOOL *stop)
     {
         NSMutableArray* assetImages = [NSMutableArray array];
         std::vector<cv::Mat> IV;
         if(group){
             
             
             
             //コールバック関数を実装
             ALAssetsGroupEnumerationResultsBlock assetsEnumerationBlock =
             ^(ALAsset *asset, NSUInteger index, BOOL *stop)
             {
                 
                 if (asset)
                 {
                     //ALAssetRepresentationクラスのインスタンスを作成
                     //assetはALAssetのインスタンス
                     ALAssetRepresentation *rep = [asset defaultRepresentation];
                     UIImage *img = [[UIImage alloc] initWithCGImage:[rep fullScreenImage]];
                     [assetImages addObject:img];
                 }
             };
             
             //アセットの取得
             [group enumerateAssetsUsingBlock:assetsEnumerationBlock];
             
             
             for (UIImage* img in assetImages) {
                 cv::Mat M;
                 UIImageToMat(img, M);
                 IV.push_back(M);
             }
             
             UIImage* baseImg = [UIImage imageNamed:@"lena.jpg"];
             cv::Mat bM;
             UIImageToMat(baseImg, bM);
             CPP::CvLib *lib = new CPP::CvLib(30);
             cv::Mat res = lib->makeMozArt(bM, IV);
             self.imageView.image = MatToUIImage(res);
             defaultIMG = self.imageView.image;
         }
     } failureBlock:nil];
    
    self.grayButton.enabled = true;
    self.BlurButton.enabled = true;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}  


- (IBAction)GrayButtonAction:(id)sender {
    if(grayflag == false){
    UIImage* img = self.imageView.image;
    cv::Mat mat;
    UIImageToMat(img, mat);
    cv::Mat *mat2 = new cv::Mat(mat.rows, mat.cols, CV_8UC1);
        cv::cvtColor(mat, *mat2, CV_BGR2GRAY);
        UIImage* img2 = MatToUIImage(*mat2);
    self.imageView.image = img2;
        grayflag = true;
    }
    else{
        self.imageView.image = defaultIMG;
        grayflag = false;
    }
}

- (IBAction)BlurButton:(id)sender {
    UIImage* img = self.imageView.image;
    cv::Mat mat;
    UIImageToMat(img, mat);
    cv::Mat mat2 = [openCVLib toBlur:mat];
    UIImage* img2 = MatToUIImage(mat2);
    self.imageView.image = img2;
}
@end
