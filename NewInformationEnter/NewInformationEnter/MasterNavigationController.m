//
//  MasterNavigationControllerViewController.m
//  NewInformationEnter
//
//  Created by sunlight on 14-4-1.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "MasterNavigationController.h"

@interface MasterNavigationController ()

@end

@implementation MasterNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //隐藏原来的导航控制器，自定义导航控制器(覆盖不隐藏，除非将tableViewController的view再套在一个UIView里面，并改变UIView的frame)
    //隐藏以后，xib创建的tableView会整体上移，因此取消动画效果,并且取消隐藏
    //self.navigationBar.hidden = YES;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top"]];
    imageView.frame = CGRectMake(0, 0, 330, 44);
    imageView.userInteractionEnabled = YES;
    
    //自定义UIButton代替UINavigationBarButtonItem
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 5, 75, 35);
    [backButton setBackgroundImage:[UIImage imageNamed:@"back1"] forState:UIControlStateNormal];
    //增加退出按钮返回到登录页面事件
    [backButton addTarget:self action:@selector(returnLoginPage) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:backButton];
    
    //增加label文字
    UILabel *titileLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, 65, 44)];
    titileLabel.text = @"请选择";
    titileLabel.font = [UIFont systemFontOfSize:16];
    titileLabel.textColor = [UIColor whiteColor];
    [imageView addSubview:titileLabel];
    
    [self.view addSubview:imageView];
    //自定义导航器结束
}

//返回登录页面按钮事件
- (void)returnLoginPage{
    
    //这里存在内存泄露
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    LoginViewController *viewController = [[LoginViewController alloc] init];
    delegate.window.rootViewController = viewController;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
