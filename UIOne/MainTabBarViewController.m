//
//  MainTabBarViewController.m
//  UIOne
//
//  Created by sunlight on 14-5-23.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#define kMenuButtonLeftSpace 10.0f
#define kMenuButtonWidth 80.0f
#define KMenuButtonHeight 50.0f
#define kMenuButtonMiddleSpace 150.0f

#import "MainTabBarViewController.h"

@interface MainTabBarViewController ()

@property (nonatomic,strong) UIView *leftTabBarView;

@end

@implementation MainTabBarViewController

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
    //设置frame
    self.view.frame = CGRectMake(0, 0, 1024, 768);
    //创建自定义视图
    [self createCustomView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma private methods

- (void)createCustomView{
    
    //隐藏原先tabbar，自定义tabbar
    self.tabBar.hidden = YES;
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 768)];
    leftView.userInteractionEnabled = YES;
    leftView.backgroundColor = [UIColor grayColor];
    leftView.tag = 1028;
    
    float beginY = 150.0f;
    //录入问卷按钮
    UIButton *fillButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    fillButton.tag = 0;
    [fillButton setTitle:@"录入问卷" forState:UIControlStateNormal];
    [fillButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    fillButton.frame = CGRectMake(kMenuButtonLeftSpace, beginY, kMenuButtonWidth, KMenuButtonHeight);
    [fillButton addTarget:self action:@selector(changeSelectIndex:) forControlEvents:UIControlEventTouchUpInside];
    beginY += kMenuButtonMiddleSpace;
    
    //问卷管理按钮
    UIButton *questionManageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    questionManageButton.tag = 1;
    [questionManageButton setTitle:@"问卷管理" forState:UIControlStateNormal];
    [questionManageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [questionManageButton addTarget:self action:@selector(changeSelectIndex:) forControlEvents:UIControlEventTouchUpInside];
    questionManageButton.frame = CGRectMake(kMenuButtonLeftSpace, beginY, kMenuButtonWidth, KMenuButtonHeight);
    
    //设置按钮
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    settingButton.tag = 2;
    [settingButton setTitle:@"设置" forState:UIControlStateNormal];
    [settingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    settingButton.frame = CGRectMake(kMenuButtonLeftSpace,768-100, kMenuButtonWidth, KMenuButtonHeight);
    
    [leftView addSubview:fillButton];
    [leftView addSubview:questionManageButton];
    [leftView addSubview:settingButton];
    self.leftTabBarView = leftView;
    [self.view addSubview:leftView];
    
    fillButton.selected = YES;
    self.selectedIndex = 0;
}

- (void)changeSelectIndex:(UIButton *)button{
    NSLog(@"%lu",(unsigned long)self.selectedIndex);
    if (button.tag != self.selectedIndex) {
        UIButton *preButton = (UIButton *)[self.leftTabBarView viewWithTag:self.selectedIndex];
        preButton.selected = NO;
        self.selectedIndex = button.tag;
        button.selected = YES;
    }
    
}
@end
