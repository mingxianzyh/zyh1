//
//  PayNavigationControllerViewController.m
//  UITableTest
//
//  Created by sunlight on 14-3-17.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import "PayNavigationControllerViewController.h"

@interface PayNavigationControllerViewController ()

@end

@implementation PayNavigationControllerViewController

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
    // Do any additional setup after loading the view from its nib.
    self.navigationBarHidden = NO;
    self.title = @"支付";
    self.view.backgroundColor = [UIColor  redColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
