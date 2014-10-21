//
//  MainViewController.m
//  ScanDemo
//
//  Created by sunlight on 14-9-16.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "MainViewController.h"
#import "MainScanViewController.h"
#import "PrivateSettingViewController.h"
#import "MoreViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    [self initViewControllers];
}

- (void)initViewControllers{
    
    //扫描结果
    MainScanViewController *scanVC = [[MainScanViewController alloc] init];
    UINavigationController *scanNV = [[UINavigationController alloc] initWithRootViewController:scanVC];
    scanNV.title = @"扫描结果";
    
    //个人设置
    PrivateSettingViewController *privateSettingVC = [[PrivateSettingViewController alloc] init];
    UINavigationController *privateSettingNV = [[UINavigationController alloc] initWithRootViewController:privateSettingVC];
    privateSettingNV.title = @"个人设置";
    
    //更多信息
    MoreViewController *moreVC = [[MoreViewController alloc] init];
    UINavigationController *moreNV = [[UINavigationController alloc] initWithRootViewController:moreVC];
    moreNV.title = @"更多信息";
    
    self.viewControllers = @[scanNV,privateSettingNV,moreNV];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
