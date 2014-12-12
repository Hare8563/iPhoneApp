//
//  iOSViewController.h
//  iOSStudy02
//
//  Created by 哲士 晴佐久 on 12/06/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iOSViewController : UIViewController <UITextFieldDelegate>//<-これを実装しないとダメ
@property (weak, nonatomic) IBOutlet UILabel *lbl01;
@property (weak, nonatomic) IBOutlet UITextField *tf01;
- (IBAction)bt01:(id)sender;

@end
