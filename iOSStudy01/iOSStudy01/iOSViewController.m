//
//  iOSViewController.m
//  iOSStudy01
//
//  Created by 哲士 晴佐久 on 12/06/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "iOSViewController.h"

@interface iOSViewController ()

@end

@implementation iOSViewController
@synthesize HelloRes;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    HelloRes.text=@"ようこそ";
}

- (void)viewDidUnload
{
    [self setHelloRes:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)HelloButton:(id)sender {
     HelloRes.text= @"こんにちは";
}
@end
