//
//  AppDelegate.m
//  NewInformationEnter
//
//  Created by sunlight on 14-4-1.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    self.window.rootViewController = loginViewController;
    
//如果时区设置正常的话，则[NSDate date]得到的是正常的结果，但调用description默认调用的是格林时间打印(需要使用descriptionWithLocale进行打印，或者使用NSDateFormat)
//    NSDateFormatter *format = [[NSDateFormatter alloc] init];
//    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *date = [NSDate date];
//    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
//    NSLog(@"%@",[date descriptionWithLocale:locale]);
//    NSLog(@"%@",[format stringFromDate:date]);
    
    
    //NSCharacterSet 是一系列字符集合
    //rangeOfCharacterFromSet:charSet 会判断当前字符串第一个字符是否在charSet中存在，如果存在则返回当前字符串的range，不进行其他的字符判断;如果不存在则会判断第二个字符，以此类推.
//    NSString *str = @"..0..0";
//    NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:WSDNUMBERS];
//    
//    NSRange range = [str rangeOfCharacterFromSet:charSet];

    
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
