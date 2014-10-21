//
//  ViewController.m
//  AdjustIOS8
//
//  Created by sunlight on 14-9-23.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    NSLog(@"%@",[[UIDevice currentDevice] systemVersion]);
    if ([self respondsToSelector:@selector(showDetailViewController:sender:)]) {
        NSLog(@"是");
    }else{
        NSLog(@"否");
    }
#endif
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] init];
    UIImage *image;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    image = [navigationController.navigationBar
                                  backgroundImageForBarMetrics:UIBarMetricsCompact];
    NSLog(@"%d",UIBarMetricsCompact);
    
#else
    image = [navigationController.navigationBar
                                  backgroundImageForBarMetrics:UIBarMetricsLandscapePhone];
#endif
    NSLog(@"%@",image);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
