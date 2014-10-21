//
//  ContentViewController.m
//  NewInformationEnter
//
//  Created by sunlight on 14-4-2.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

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
    
    UIButton *savebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [savebutton setBackgroundImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
    [savebutton addTarget:self action:@selector(saveData) forControlEvents:UIControlEventTouchUpInside];
    savebutton.frame = CGRectMake(0, 4, 75, 36);
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:savebutton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
}

//空实现-要求子类实现(如果子类未重写，则会调用当前方法)
- (void)saveData{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
