//
//  iOSViewController.h
//  iOSStudy01
//
//  Created by 哲士 晴佐久 on 12/06/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iOSViewController : UIViewController
- (IBAction)HelloButton:(id)sender;//入力
@property (weak, nonatomic) IBOutlet UILabel *HelloRes;//出力

@end
