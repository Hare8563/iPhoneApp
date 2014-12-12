//
//  iOSViewController.m
//  iOSStudy02
//
//  Created by 哲士 晴佐久 on 12/06/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "iOSViewController.h"

@interface iOSViewController ()

@end

@implementation iOSViewController
@synthesize lbl01;
@synthesize tf01;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setLbl01:nil];
    [self setTf01:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)bt01:(id)sender {
    NSString *res=[[NSString alloc] initWithFormat:@"Hello %@ !",self.tf01.text];
    lbl01.text=res;
}
//テキストの入力を終了させる
-(BOOL)textFieldShouldReturn:(UITextField *)theTextField{
    if(theTextField == tf01){
        [theTextField resignFirstResponder];
    }
    return YES;
}
@end
