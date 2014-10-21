//
//  ViewController.m
//  LocalNotification
//
//  Created by sunlight on 14-7-15.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)presentLocalNotice:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)presentLocalNotice:(id)sender {
    
    UILocalNotification *localNotice = [[UILocalNotification alloc] init];
    localNotice.alertBody = @"测试1";
    localNotice.alertAction = @"123";
    localNotice.soundName = UILocalNotificationDefaultSoundName;
    localNotice.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber]+1;
    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotice];
}
@end
