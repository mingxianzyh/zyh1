//
//  BaseViewController.m
//  NewInformationEnter
//
//  Created by sunlight on 14-4-15.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomTabBarControllerViewController.h"
#import "CustomTabBarControllerViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

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
    //自定义BarButtonItem
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 4, 36, 36);
    [button addTarget:self action:@selector(showPopoverView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftButtonItem;

}
//点击按钮显示导航控制器
- (void)showPopoverView{
    
    CustomTabBarControllerViewController *tabBarController = (CustomTabBarControllerViewController*)self.navigationController.tabBarController;
    if(tabBarController.popController){
        //master popoverController不需要设置Rect,且无法改变
        [tabBarController.popController presentPopoverFromRect:CGRectMake(0, 0, 0, 0) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    }
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
