//
//  imageViewController.h
//  Camera
//
//  Created by Tetsushi on 2014/11/12.
//  Copyright (c) 2014年 Kojima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface imageViewController : UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate>
- (IBAction)SnapButtonAction:(id)sender;

@end
