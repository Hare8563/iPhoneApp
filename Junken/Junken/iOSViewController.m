//
//  iOSViewController.m
//  Junken
//
//  Created by 哲士 晴佐久 on 12/06/28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "iOSViewController.h"

@interface iOSViewController ()

@end

@implementation iOSViewController
int myResult;
int enemyResult;
BOOL jankenResult;
@synthesize rasult;
@synthesize enemyData;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    enemyData.text=@"敵の手";
    rasult.text=@"あなたの勝敗";
}

- (void)viewDidUnload
{
    [self setRasult:nil];
    [self setEnemyData:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)Guu:(id)sender {
    enemyResult=rand()%3;
    
    if(enemyResult==0) enemyData.text=@"ぐう";
    else if(enemyResult==1) enemyData.text=@"ちょき";
    else enemyData.text=@"ぱぁ";
    
    myResult=0;
    jankenResult=[self returnYourResult:enemyResult:myResult];
    if(jankenResult==YES) rasult.text=@"win";
    else rasult.text=@"lose";
}

- (IBAction)tyoki:(id)sender {
    enemyResult=rand()%3;
    
    if(enemyResult==0) enemyData.text=@"ぐう";
    else if(enemyResult==1) enemyData.text=@"ちょき";
    else enemyData.text=@"ぱぁ";
    

    myResult=1;
    jankenResult=[self returnYourResult:enemyResult:myResult];
    if(jankenResult==YES) rasult.text=@"win";
    else rasult.text=@"lose";
}

- (IBAction)paa:(id)sender {
    enemyResult=rand()%3;
    
    if(enemyResult==0) enemyData.text=@"ぐう";
    else if(enemyResult==1) enemyData.text=@"ちょき";
    else enemyData.text=@"ぱぁ";
    

    myResult=2;
    jankenResult=[self returnYourResult:enemyResult:myResult];
    if(jankenResult==YES) rasult.text=@"win";
    else rasult.text=@"lose";
}

-(BOOL)returnYourResult:(int)factor1:(int)factor2{
    if(factor1==factor2){
        return NO;
    }
    else if(factor1==0){
        if(factor2==1){
            return NO;
        }
        else if(factor2==2){
            return YES;
        }
    }
    else if(factor1==1){
        if(factor2==0){
            return YES;
        }
        else if(factor2==2){
            return NO;   
        }
    }
    else if(factor1==2){
        if(factor2==0){
            return NO;
        }
        else if(factor2==1){
            return YES;   
        }
    }
    return YES;
}


@end
