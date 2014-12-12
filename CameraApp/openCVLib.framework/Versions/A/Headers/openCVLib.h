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
#include <vector>

@interface openCVLib : NSObject

+(UIImage *)UIImageFromMatBGR:(cv::Mat)image;
+(cv::Mat)cvMatFromUIImage:(UIImage *)image;
+(cv::Mat)toMoz:(cv::Mat)baseImg MozSize:(int)size;
+(cv::Mat)toGray:(cv::Mat)mat;
+(std::vector<cv::Mat>)stdVectorFromUIImageArray:(NSArray*)array;
//+(cv::Mat)toSepia:(cv::Mat)mat;
+(cv::Mat)toBlur:(cv::Mat)mat;
+(cv::Mat)rotation:(cv::Mat)mat Anglar:(float)angle;
@end


namespace CPP {
    class CvLib{
    private:
        int blockSize;
    public:
        CvLib(int blockSize);
        ~CvLib();
        cv::Mat makeMozArt(cv::Mat baseImage, std::vector<cv::Mat> imgs);
        int getNN(cv::Scalar target,  const std::vector<cv::Scalar>& colors);
    };
}
