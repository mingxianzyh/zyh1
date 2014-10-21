//
//  LoginViewController.m
//  NewInformationEnter
//
//  Created by sunlight on 14-4-1.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "LoginViewController.h"
#import "MainSplitViewController.h"
#import "MasterTableController.h"
#import "AppDelegate.h"
#import "CustomTabBarControllerViewController.h"
#import "MasterNavigationController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    

    //分栏左侧主导航控制器
    MasterTableController *masterTableController = [[MasterTableController alloc] init];
    MasterNavigationController *masterNavigationControlelr = [[MasterNavigationController alloc] initWithRootViewController:masterTableController];
    
    //右侧明细tabBar控制器
    CustomTabBarControllerViewController *detailTabBarController = [[CustomTabBarControllerViewController alloc] init];
    detailTabBarController.view.frame = CGRectMake(0, 0, 768, 1004);
    
    //主split控制器
    MainSplitViewController *splitViewController = [[MainSplitViewController alloc] init];
    NSArray *controllers = @[masterNavigationControlelr,detailTabBarController];
    splitViewController.viewControllers = controllers;
    //设置代理(官方Demo放在明细控制器中)
    splitViewController.delegate = detailTabBarController;
//    
//    [UIView beginAnimations:@"changeLogin" context:nil];
//    [UIView setAnimationDuration:0.5];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:NO];
    //替换根视图控制器
    AppDelegate *delegate = (AppDelegate*)([UIApplication sharedApplication].delegate);
    delegate.window.rootViewController = splitViewController;
    
//    [UIView commitAnimations];
}

- (IBAction)touchDoneKey:(UITextField *)sender {
    
    [sender resignFirstResponder];
}
@end
