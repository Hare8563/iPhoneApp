//
//  ImagePickerDelegate.m
//  Camera
//
//  Created by Tetsushi on 2014/11/12.
//  Copyright (c) 2014年 Kojima. All rights reserved.
//

#import "ImagePickerDelegate.h"
#import <opencv2/highgui/ios.h>

@implementation ImagePickerDelegate

- (void)imagePickerController :(UIImagePickerController *)picker
        didFinishPickingImage :(UIImage *)image editingInfo :(NSDictionary *)editingInfo {
    
    ALAssetsLibrary* library;
    library = [[ALAssetsLibrary alloc] init];
    
    
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:
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
             _image = MatToUIImage(res);
         }
     } failureBlock:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

