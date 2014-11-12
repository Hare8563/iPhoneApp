//
//  imageViewController.m
//  Camera
//
//  Created by Tetsushi on 2014/11/12.
//  Copyright (c) 2014年 Kojima. All rights reserved.
//

#import "imageViewController.h"

@interface imageViewController ()

@end

@implementation imageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SnapButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
