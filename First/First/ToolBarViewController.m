//
//  ToolBarViewController.m
//  First
//
//  Created by sunlight on 14-3-10.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import "ToolBarViewController.h"

@interface ToolBarViewController ()

@end

@implementation ToolBarViewController

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
    //开始加载蓝色视图
    BlueViewController *blueViewController = [[BlueViewController alloc] initWithNibName:@"BlueViewController" bundle:nil];
    	
    self.blueViewController = blueViewController;
    [self.view insertSubview:blueViewController.view atIndex:0];
    [blueViewController release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //说明蓝色视图的并未显示
    if(self.blueViewController.view.superview==nil){
        self.blueViewController = nil;
    }else{
        self.greenViewContriller = nil;
    }
}

- (void)dealloc{
    [_blueViewController release];
    [_greenViewContriller release];
    [super dealloc];
}

- (IBAction)switchView:(id)sender {
    //开始动画
    [UIView beginAnimations:@"changeView" context:nil];
    //设定延迟时间
    [UIView setAnimationDelay:0.5];
    //设定淡出淡入效果
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    if(self.blueViewController.view.superview == nil){
        if(self.blueViewController.view==nil){
            BlueViewController *blueCiewController = [[BlueViewController alloc] initWithNibName:@"BlueViewController" bundle:nil];
            self.blueViewController = blueCiewController;
            [blueCiewController release];
        }
        [self.greenViewContriller.view removeFromSuperview];
        [self.view insertSubview:self.blueViewController.view atIndex:0];
        //设置动画翻转的效果以及其他属性
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    }else{
        if(self.greenViewContriller.view.superview == nil){
            if (self.greenViewContriller.view == nil) {
                GreenViewController *greenViewController = [[GreenViewController alloc] initWithNibName:@"GreenViewController" bundle:nil];
                self.greenViewContriller = greenViewController;
                [greenViewController release];
            }
        }

        [self.blueViewController.view removeFromSuperview];
        [self.view insertSubview:self.greenViewContriller.view atIndex:0];
                [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];	
    }
    //动画结束
    [UIView commitAnimations];
}
@end
