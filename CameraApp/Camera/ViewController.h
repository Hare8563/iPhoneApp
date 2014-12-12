//
//  ViewController.h
//  Camera
//
//  Created by hanasake on 2014/11/08.
//  Copyright (c) 2014年 Kojima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <openCVLib/openCVLib.h>
#import "imageViewController.h"

@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate,imageViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *grayButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *BlurButton;
- (IBAction)GrayButtonAction:(id)sender;
- (IBAction)BlurButton:(id)sender;
-(void)modalViewDidDissmissed:(NSInteger)tag;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

