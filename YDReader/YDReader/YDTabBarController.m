//
//  YDTabBarController.m
//  YDReader
//
//  Created by sunlight on 14-10-9.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//
#import "AppDelegate.h"
#import "YDTabBarController.h"
#import "YDNavigationController.h"
#import "BookStoreViewController.h"
#import "BookMarkViewController.h"
#import "UploadViewController.h"
#import "SettingViewController.h"
#import "UserInfoViewController.h"
#import "BookStoreViewController_Iphone.h"
#import "BookMarkViewController_Iphone.h"
#import "UploadViewController_Iphone.h"
#import "SettingViewController_Iphone.h"
#import "UserInfoViewController_Iphone.h"

@interface YDTabBarController ()

@end

@implementation YDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.translucent = NO;
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSMutableArray *viewControllers = [[NSMutableArray alloc] initWithCapacity:5];
    if (appDelegate.isIphone) {
        
    }else{
        //书库
        BookStoreViewController *bookStoreVC = [[BookStoreViewController alloc] init];
        UINavigationController *nc1 = [[YDNavigationController alloc] initWithRootViewController:bookStoreVC];
        nc1.tabBarItem.title = NSLocalizedString(@"BookStore", @"");
        bookStoreVC.navigationItem.title = NSLocalizedString(@"BookStore", @"");
        [viewControllers addObject:nc1];
        
        //书签
        BookMarkViewController *bookMarkVC = [[BookMarkViewController alloc] init];
        UINavigationController *nc2 = [[YDNavigationController alloc] initWithRootViewController:bookMarkVC];
        nc2.tabBarItem.title = NSLocalizedString(@"BookMark", @"");
        bookMarkVC.navigationItem.title = NSLocalizedString(@"BookMark", @"");
        [viewControllers addObject:nc2];
        
        //上传
        UploadViewController *uploadVC = [[UploadViewController alloc] init];
        UINavigationController *nc3 = [[YDNavigationController alloc] initWithRootViewController:uploadVC];
        nc3.tabBarItem.title = NSLocalizedString(@"Upload", @"");
        uploadVC.navigationItem.title = NSLocalizedString(@"Upload", @"");
        [viewControllers addObject:nc3];
        
        //设置
        SettingViewController *settingVC = [[SettingViewController alloc] init];
        UINavigationController *nc4 = [[YDNavigationController alloc] initWithRootViewController:settingVC];
        nc4.tabBarItem.title = NSLocalizedString(@"Setting", @"");
        settingVC.navigationItem.title = NSLocalizedString(@"Setting", @"");
        [viewControllers addObject:nc4];
        
        //用户
        UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
        UINavigationController *nc5 = [[YDNavigationController alloc] initWithRootViewController:userInfoVC];
        nc5.tabBarItem.title = NSLocalizedString(@"UserInfo", @"");
        userInfoVC.navigationItem.title = NSLocalizedString(@"UserInfo", @"");
        [viewControllers addObject:nc5];
    }
    self.viewControllers = viewControllers;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
