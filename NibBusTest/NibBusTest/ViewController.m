//
//  ViewController.m
//  NibBusTest
//
//  Created by sunlight on 14-7-24.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableAttributedString+NimbusAttributedLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NIAttributedLabel *label = [[NIAttributedLabel alloc] initWithFrame:CGRectMake(50, 50, 300, 300)];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"hello"];
    [str setFont:[UIFont systemFontOfSize:20]];
    [str setTextColor:[UIColor redColor]];
    [str setTextColor:[UIColor greenColor] range:[@"hello" rangeOfString:@"o"]];
    label.attributedText = str;
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
