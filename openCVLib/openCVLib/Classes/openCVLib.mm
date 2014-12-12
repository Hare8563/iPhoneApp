//
//  openCVLib.m
//  openCVLib
//
//  Created by Tetsushi on 2014/11/08.
//  Copyright (c) 2014年 Tetsushi. All rights reserved.
//

#import "openCVLib.h"

@implementation openCVLib



+ (UIImage *)UIImageFromMatBGR:(cv::Mat)image {
    cv::cvtColor(image,image, CV_BGR2RGB);  //追記しました．
    NSData *data = [NSData dataWithBytes:image.data length:image.elemSize()*image.total()];
    CGColorSpaceRef colorSpace;
    if (image.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(image.cols,                                 //width
                                        image.rows,                                 //height
                                        8,                                          //bits per component
                                        8 * image.elemSize(),                       //bits per pixel
                                        image.step.p[0],                            //bytesPerRow
                                        colorSpace,                                 //colorspace
                                        kCGImageAlphaNone|kCGBitmapByteOrderDefault,// bitmap info
                                        provider,                                   //CGDataProviderRef
                                        NULL,                                       //decode
                                        false,                                      //should interpolate
                                        kCGRenderingIntentDefault                   //intent
                                        );
    
    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    return finalImage;
}


+ (cv::Mat)cvMatFromUIImage:(UIImage *)image
{
    CGImageRef imageRef = image.CGImage;
    cv::Mat cvMat(image.size.height, image.size.width, CV_8UC4);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef contextRef;
    
    contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to  data
                                       cvMat.cols,                       // Width of bitmap
                                       cvMat.rows,                       // Height of bitmap
                                       8,                          // Bits per component
                                       cvMat.step,              // Bytes per row
                                       colorSpace,                 // Colorspace
                                       kCGImageAlphaPremultipliedLast|kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef,CGRectMake(0, 0, image.size.width, image.size.height), imageRef);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);
    
    
    
    cv::Mat ret = cv::Mat( image.size.width, image.size.height, CV_8UC3 );
    cv::cvtColor(cvMat, ret, CV_RGBA2BGR);  //変更しました．
    return ret;
}


+(cv::Mat)toGray:(cv::Mat)mat{
    cv::Mat grayMat;
    cv::cvtColor(mat, grayMat, CV_BGR2GRAY);
    return grayMat;
}

+(cv::Mat)rotation:(cv::Mat)mat Anglar:(float)angle{
    cv::Mat R, dst;
    float m[6];
    m[0] = (float)(cos(angle*CV_PI / 180.));
    m[1] = (float) (-sin (angle * CV_PI / 180.));
    m[2] = mat.cols * 0.5;
    m[3] = -m[1];
    m[4] = m[0];
    m[5] = mat.rows * 0.5;
    CvMat MM = R;
    cvInitMatHeader (&MM, 2, 3, CV_32FC1, m, CV_AUTOSTEP);
    // (3)指定された回転行列により，GetQuadrangleSubPixを用いて画像全体を回転させる
    IplImage src_img = mat;
    IplImage dst_img = dst;
    cvGetQuadrangleSubPix (&src_img, &dst_img, &MM);
    dst = &dst_img;
    return dst;
}

+(cv::Mat)toMoz:(cv::Mat)baseImg MozSize:(int)size{
    cv::Mat dst = baseImg.clone();
    int blue,green,red;
    int tmp1,tmp2;
    
    for(int y=0;y<baseImg.rows;y+=size){
        for(int x=0;x<baseImg.cols;x+=size){
            blue = 0;
            green = 0;
            red = 0;
            
            for(int i=0;i<size;i++){
                if(baseImg.rows < (y+i)) break;
                tmp1 = i;
                for (int j=0;j<size;j++) {
                    if(baseImg.cols < (x+j))break;
                    blue += baseImg.at<cv::Vec3b>((y+i),(x+j))[0];
                    green += baseImg.at<cv::Vec3b>((y+i),(x+j))[1];
                    red += baseImg.at<cv::Vec3b>((y+i),(x+j))[2];
                    tmp2 = j;
                }
            }
            tmp1++;
            tmp2++;
            for(int i=0;i<tmp1;i++){
                for(int j=0;j<tmp2;j++){
                    dst.at<cv::Vec3b>((y+i),(x+j))[0] = cvRound(blue / (tmp1 * tmp2));
                    dst.at<cv::Vec3b>((y+i),(x+j))[1] = cvRound(green / (tmp1 * tmp2));
                    dst.at<cv::Vec3b>((y+i),(x+j))[2] = cvRound(red / (tmp1 * tmp2));
                }
            }
        }
    }
    return dst;
}

//+(cv::Mat)toSepia:(cv::Mat)mat{
//    CvScalar valueH = cvScalar(22);
//    CvScalar valueS = cvScalar(90);
//    
//    cv::Mat HueImage, SaturatinImage, ValueImage;
//    cv::Mat  HSVImage,MeargeImage,sepia;
//
//    cv::cvtColor(mat, HSVImage, CV_BGR2HSV);
//    cvSplit(HSVImage, HueImage, SaturatinImage, ValueImage, NULL);
//    
//    cvSet(HueImage, valueH, NULL);
//    cvSet(SaturatinImage, valueS,NULL);
//    cvMerge(HueImage, SaturatinImage, ValueImage, NULL, MeargeImage);
//    cv::cvtColor(MeargeImage, sepia, CV_HSV2BGR);
//
//    return sepia;
//}

+(cv::Mat)toBlur:(cv::Mat)mat{
    cv::Mat M;
    cv::GaussianBlur(mat, M, cv::Size(11,11),10, 10);
    return M;
}

//arrayがUIImageのArrayの場合
+(std::vector<cv::Mat>)stdVectorFromUIImageArray:(NSArray*)array{
    std::vector<cv::Mat> M;

    for (UIImage *img in array) {
        cv::Mat m = [self cvMatFromUIImage:img];
        M.push_back(m);
    }
    
    return M;
}

@end

//CPlusPlusのクラス
namespace CPP{
CvLib::CvLib(int blockSize){
    this->blockSize = blockSize;
}

CvLib::~CvLib(){
    blockSize = 0;
}

cv::Mat CvLib::makeMozArt(cv::Mat baseImage, std::vector<cv::Mat> imgs){
    std::vector<cv::Mat> resizedImgs;
    std::vector<cv::Scalar> colors;
    
    for(int i=0;i<imgs.size();i++){
        cv::Mat hsv,resized;
        cv::Mat colorImage = imgs[i];
        cv::cvtColor(colorImage, hsv, CV_BGR2HSV);
        
        colors.push_back(cv::mean(hsv));
        cv::resize(hsv, resized, cv::Size(this->blockSize,this->blockSize));
        resizedImgs.push_back(resized);
    }
    
    cv::Mat hsvBase;
    cv::cvtColor(baseImage, hsvBase, CV_BGR2HSV);
    
    //モザイクアート作成
    for(int y = 0; y < baseImage.rows ; y+= blockSize) {
        for(int x = 0; x < baseImage.cols ; x+= blockSize) {
            int w =MIN(blockSize,baseImage.cols-x);
            int h =MIN(blockSize,baseImage.rows-y);
            cv::Mat roi = hsvBase(cv::Rect(x,y,w,h));//注目領域だけ取得
            cv::Scalar color = cv::mean(roi);
            
            int minIdx = getNN(color,colors);
            NSLog(@"%d\n",minIdx);
            resizedImgs[minIdx].copyTo(roi);// 注目領域のすべてのピクセルをhsvの平均値で初期化
        }
    }
    
    cv::Mat res;
    cv::cvtColor(hsvBase, res, CV_HSV2BGR);
    return res;
}

int  CvLib::getNN(cv::Scalar target,  const std::vector<cv::Scalar>& colors){
    double minNorm = 1.0e100;
    int minIdx = 1e10;
    for(int i = 0; i < colors.size() ; i++) {
        double diff = cv::norm(target ,colors[i]);
        
        if ( diff < minNorm ){
            minIdx = i;
            minNorm = diff;
        }
    }
    return minIdx;
}
}

