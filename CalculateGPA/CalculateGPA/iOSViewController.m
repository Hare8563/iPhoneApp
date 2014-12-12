//
//  iOSViewController.m
//  CalculateGPA
//
//  Created by Tetsushi on 2012/08/14.
//  Copyright (c) 2012年 Tetsushi. All rights reserved.
//

#import "iOSViewController.h"

@interface iOSViewController ()

@end

@implementation iOSViewController
@synthesize resultLabel;
@synthesize textA;
@synthesize textB;
@synthesize textC;
@synthesize textD;
@synthesize textF;

- (void)viewDidLoad
{
    [super viewDidLoad];
    textA.text = @"0";
    textB.text = @"0";
    textC.text = @"0";
    textD.text = @"0";
    textF.text = @"0";
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    textA = nil;
    [self setTextA:nil];
    [self setTextB:nil];
    [self setTextC:nil];
    [self setTextD:nil];
    [self setTextF:nil];
    [self setResultLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)calcurateGPA:(id)sender {
    dataA = [textA.text intValue];
    dataB = [textB.text intValue];
    dataC = [textC.text intValue];
    dataD = [textD.text intValue];
    dataF = [textF.text intValue];
    sum = dataA+dataB+dataC+dataD+dataF;
    
    dataA*=4;
    dataB*=3;
    dataC*=2;
    dataD = 0;
    dataF = 0;
    
    resultLabel.text = [NSString stringWithFormat:@"%f", (float)(dataA+dataB+dataC)/sum];
    
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    // 引き続き既定の動作を行わせたい場合に YES を返します。
    //if(textField==textA){
        [textField resignFirstResponder];
    //}
    return YES;
}

@end
