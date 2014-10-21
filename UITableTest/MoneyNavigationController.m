//
//  MoneyNavigationController.m
//  UITableTest
//
//  Created by sunlight on 14-3-17.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import "MoneyNavigationController.h"

@interface MoneyNavigationController ()

@end

@implementation MoneyNavigationController

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

    self.view.backgroundColor = [UIColor  greenColor];
    self.navigationBarHidden = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
