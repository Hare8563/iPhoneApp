//
//  iOSViewController.h
//  CalculateGPA
//
//  Created by Tetsushi on 2012/08/14.
//  Copyright (c) 2012年 Tetsushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iOSViewController : UIViewController<UITextFieldDelegate>{
    NSUInteger dataA;
    NSUInteger dataB;
    NSUInteger dataC;
    NSUInteger dataD;
    NSUInteger dataF;
    NSUInteger sum;
    
}
@property (weak, nonatomic) IBOutlet UITextField *textA;
@property (weak, nonatomic) IBOutlet UITextField *textB;
@property (weak, nonatomic) IBOutlet UITextField *textC;
@property (weak, nonatomic) IBOutlet UITextField *textD;
@property (weak, nonatomic) IBOutlet UITextField *textF;
- (IBAction)calcurateGPA:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end
