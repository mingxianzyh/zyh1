//
//  ApplyMedicineViewController.m
//  NewInformationEnter
//
//  Created by sunlight on 14-4-4.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "ApplyMedicineViewController.h"

@interface ApplyMedicineViewController ()

@end

@implementation ApplyMedicineViewController

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
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(768/2-100/2, 0, 100, 44)];
    label.text = @"施药记录";
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    
    //设置背景图片
//    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"main2"]];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main2"]];
    [self.view insertSubview:backgroundView atIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
