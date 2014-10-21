//
//  AppDelegate.m
//  ControllerTest
//
//  Created by sunlight on 14-3-12.
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
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    UITabBarItem *barItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:5];
    UIViewController *first = [[UIViewController alloc] init];
    
    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
    
    [first setTitle:@"1"];
    
    [firstNav setTabBarItem:barItem];
    
    first.view.backgroundColor = [UIColor redColor];
    [barItem release];
    UIViewController *second = [[UIViewController alloc] init];
    [second setTitle:@"2"];
    second.view.backgroundColor = [UIColor purpleColor];
    UINavigationController *secondNav = [[UINavigationController alloc] initWithRootViewController:second];
    
    UIViewController *three = [[UIViewController alloc] init];
    [three setTitle:@"3"];
    three.view.backgroundColor = [UIColor greenColor];
    UINavigationController *threeNav = [[UINavigationController alloc] initWithRootViewController:three];
    
    UIViewController *four = [[UIViewController alloc] init];
    [four setTitle:@"4"];
    four.view.backgroundColor = [UIColor yellowColor];
    UINavigationController *fourNav = [[UINavigationController alloc] initWithRootViewController:four];
    
    
    NSArray *items = @[firstNav,secondNav,threeNav,fourNav];
    tabBarController.viewControllers = items;
    self.window.rootViewController = tabBarController;
    [tabBarController release];
    [first release];
    [second release];
    [three release];
    [four release];
    [firstNav release];
    [secondNav release];
    [threeNav release];
    [fourNav release];
    
    	
    return YES;
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
