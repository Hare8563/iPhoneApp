//
//  imageViewController.h
//  Camera
//
//  Created by Tetsushi on 2014/11/12.
//  Copyright (c) 2014年 Kojima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
@protocol imageViewDelegate<NSObject>
-(void) modalViewDidDissmissed:(NSInteger)tag;
@end

@interface imageViewController : UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate>
{
    id<imageViewDelegate> delegate;
}

@property(nonatomic, weak)id<imageViewDelegate> delegate;
@property(nonatomic, weak)NSString* str;
-(IBAction)dissmissModal:(id)sender;

@end


