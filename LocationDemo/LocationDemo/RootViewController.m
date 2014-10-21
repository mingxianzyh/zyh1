//
//  RootViewController.m
//  LocationDemo
//
//  Created by sunlight on 14-3-26.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import "RootViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

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
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"location" forState:UIControlStateNormal];
    button.frame = CGRectMake(130, 210, 100, 40);
    [button addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)test{
    _locationManager = [[CLLocationManager alloc] init];
    
    //通过设置distance filter可以实现当位置改变超出一定范围时Location Manager才调用相应的代理方法。这样可以达到省电的目的。
    //[manager setDistanceFilter:kCLDistanceFilterNone];
    
    //设置精确度
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    
    //设置委托
    _locationManager.delegate = self;
    
    //开始定位
    [_locationManager startUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    NSLog(@"latitude:%f",newLocation.coordinate.latitude);
    NSLog(@"longitude:%f",newLocation.coordinate.longitude);
    float distance = [newLocation distanceFromLocation:oldLocation];
    NSLog(@"distance:%f",distance);
    [manager stopUpdatingLocation];
    NSLog(@"-------------------------");
    //反编码5.0以后方式
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    [coder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark *placeMark in placemarks) {
            NSLog(@"%@",placeMark);
        };
        
    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
