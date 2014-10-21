//
//  MainTabViewController.m
//  UITableTest
//
//  Created by sunlight on 14-3-17.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import "MainTabViewController.h"
#import "PayNavigationControllerViewController.h"
#import "SearchNavigationController.h"
#import "MoneyNavigationController.h"
#import "PrivateNavigationController.h"
#import "PrivateViewController.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController

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
    
    PrivateViewController *pvc = [[PrivateViewController alloc] init];
    
    PayNavigationControllerViewController *pay = [[PayNavigationControllerViewController alloc] initWithNibName:@"PayNavigationControllerViewController" bundle:nil];
    SearchNavigationController *search = [[SearchNavigationController alloc] initWithNibName:@"SearchNavigationController" bundle:nil];
    MoneyNavigationController *money = [[MoneyNavigationController alloc] initWithNibName:@"MoneyNavigationController" bundle:nil];
    PrivateNavigationController *private = [[PrivateNavigationController alloc] initWithRootViewController:pvc];
    
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"支付" image:nil tag:1];
    pay.tabBarItem = item1;
    [item1 release];
    
    
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"搜索" image:nil tag:2];
    search.tabBarItem = item2;
    [item2 release];
    
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"财富" image:nil tag:3];
    money.tabBarItem = item3;
    [item3 release];
    
    UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"个人" image:nil tag:1];
    private.tabBarItem = item4;
    [item4 release];
    
    NSArray *array = @[pay,search,money,private];
    self.viewControllers = array;
    [pvc release];
    [pay release];
    [search release];
    [money release];
    [private release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
