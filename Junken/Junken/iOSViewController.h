//
//  iOSViewController.h
//  Junken
//
//  Created by 哲士 晴佐久 on 12/06/28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iOSViewController : UIViewController
- (IBAction)Guu:(id)sender;
- (IBAction)tyoki:(id)sender;
- (IBAction)paa:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *rasult;
@property (weak, nonatomic) IBOutlet UILabel *enemyData;
-(BOOL) returnYourResult:(int)factor1:(int)factor2; 
@end
