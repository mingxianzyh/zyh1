//
//  AppDelegate.m
//  UIviewDemo
//
//  Created by sunlight on 14-3-3.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    index = 1;
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(320/2-200/2, 100, 200, 300)];
    redView.tag = 1;
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    blueView.tag = 2;
    UIView *yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    yellowView.tag = 3; 
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(320/2-100/2, 420, 100, 40);
    [button setTitle:@"执行" forState: UIControlStateNormal];
    [button addTarget:self action:@selector(changeView) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:button];
    
    redView.backgroundColor = [UIColor redColor];
    blueView.backgroundColor = [UIColor blueColor];
    yellowView.backgroundColor = [UIColor yellowColor];
    
    [self.window addSubview:redView];
    [redView addSubview:blueView];
    [blueView addSubview:yellowView];
    
    [redView release];
    [blueView release];
    [yellowView release];
    return YES;
}

- (void) changeView{
    [UIImageView beginAnimations:@"moving" context:NULL];
    [UIImageView setAnimationDuration:2];
    [UIImageView setAnimationRepeatCount:2];
    [UIImageView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    UIView *view = [self.window viewWithTag:1];
    if (view.alpha == 0) {
        view.alpha = 1;
    }else if(view.alpha ==1){
        view.alpha = 0;
    }
    [UIImageView commitAnimations];
 }	



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
