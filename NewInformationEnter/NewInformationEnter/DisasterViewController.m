//
//  DisasterViewController.m
//  NewInformationEnter
//
//  Created by sunlight on 14-4-2.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "DisasterViewController.h"

@interface DisasterViewController ()

@end

@implementation DisasterViewController

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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(768/2-100/2, 0, 100, 44)];
    label.text = @"灾害信息";
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    
//    //设置背景图片
//    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"main2"]];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main2"]];
    [self.view insertSubview:backgroundView atIndex:0];
    [self prepareForShowView];
    
}

//进行一些View修改操作
- (void)prepareForShowView{
    
    //给TextView设置边框和圆角
    _disasterDescribe.layer.borderColor = [[UIColor grayColor] CGColor];
    _disasterDescribe.layer.borderWidth = 1;
    _disasterDescribe.layer.cornerRadius = 7;
    _disasterDescribe.layer.masksToBounds = YES;
    
    _disasterMeasure.layer.borderColor = [[UIColor grayColor] CGColor];
    _disasterMeasure.layer.borderWidth = 1;
    _disasterMeasure.layer.cornerRadius = 7;
    _disasterMeasure.layer.masksToBounds = YES;
}

#pragma textView delegate(用通知也可以实现)
//将开始编辑时 (竖屏)如果当前控件的frame的y坐标大于当前UIScreen的高度(1024/768)-216+height,则一定会被键盘遮挡
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    //UIScreen *mainScreen = [UIScreen mainScreen];
    //获取屏幕的高度
    //float screenHeight = mainScreen.bounds.size.height;
    float screenHeight = self.view.frame.size.height;
    //获取控件的高度
    float elementHeight = textView.frame.size.height;
    //获取控件的y坐标
    float elementY = textView.frame.origin.y;
    //计算偏移量
    float offSet = elementY+elementHeight+266-screenHeight;
    //如果偏移量大于0，则说明超过了屏幕的高度，需要将整个view的frame的y设置为-offset
    if (offSet>0) {
        [UIView animateWithDuration:0.4 animations:^{
            self.view.frame = CGRectMake(0, -offSet, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
    
    return YES;
}
//完成编辑后 如果frame的y小于0，则需要将frame恢复
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    //获取当前view的y坐标
    float orginY = self.view.frame.origin.y;
    //如果y小于0，说明当前view已经被上移，需要恢复y坐标
    if (orginY<0) {
        [UIView animateWithDuration:0.4 animations:^{
            //需要算上导航栏高度
            self.view.frame = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
