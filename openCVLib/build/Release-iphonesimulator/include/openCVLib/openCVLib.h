//
//  openCVLib.h
//  openCVLib
//
//  Created by Tetsushi on 2014/11/08.
//  Copyright (c) 2014年 Tetsushi. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <opencv2/opencv.hpp>

@interface openCVLib : NSObject

+(UIImage *)UIImageFromCVMat:(cv::Mat)cvMat;
+(cv::Mat)cvMatFromUIImage:(UIImage *)image;
+(cv::Mat)toMoz:(cv::Mat)baseImg MozSize:(int)size;
+(cv::Mat)toGray:(cv::Mat)mat;
+(cv::Mat)toHSV:(cv::Mat)mat;
@end
