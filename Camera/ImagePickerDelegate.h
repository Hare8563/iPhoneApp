//
//  ImagePickerDelegate.h
//  Camera
//
//  Created by Tetsushi on 2014/11/12.
//  Copyright (c) 2014年 Kojima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <openCVLib/openCVLib.h>

@interface ImagePickerDelegate : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(strong,atomic) UIImage* image;
@end
