//
//  ViewController.m
//  ViewTest
//
//  Created by sunlight on 14-5-12.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "ViewController.h"
#import "WsdSegmentView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.segment.tintColor = [UIColor grayColor];
    self.button.layer.masksToBounds = YES;
    self.button.backgroundColor = [UIColor redColor];
    self.button.layer.cornerRadius = self.button.bounds.size.width/2;
    
    Class class = NSClassFromString(@"WsdSegmentView");
    WsdSegmentView *segmentView = [[class alloc] initWithTitles:[NSArray arrayWithObjects:@"全部",@"特别关系",@"好友动态",@"认证空间", nil]];
    
    segmentView.frame = CGRectMake(self.view.bounds.size.width/2-segmentView.bounds.size.width/2, self.view.bounds.size.height/2-segmentView.bounds.size.height/2, segmentView.bounds.size.width, segmentView.bounds.size.height);
    [self.view addSubview:segmentView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
