//
//  ViewController.m
//  Quartz2D
//
//  Created by sunlight on 14-10-11.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CustomView *custonView = [[CustomView alloc] initWithFrame:self.view.bounds];
    custonView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:custonView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
