//
//  AppDelegate.m
//  LocalNotification
//
//  Created by sunlight on 14-7-15.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
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
    //启动后台任务
    UIBackgroundTaskIdentifier taskId = [application beginBackgroundTaskWithExpirationHandler:^{
        
        for (int i = 0 ; i < 50 ;i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"%d",i);
        }
        [application endBackgroundTask:taskId];
    }];
    /*
    UIBackgroundTaskIdentifier taskId = [application beginBackgroundTaskWithExpirationHandler:^{
        dispatch_queue_t queue = dispatch_queue_create("background", NULL);
        dispatch_async(queue, ^{
            
            UILocalNotification *localNotice = [[UILocalNotification alloc] init];
            localNotice.alertBody = @"测试1";
            localNotice.alertAction = @"123";
            localNotice.soundName = UILocalNotificationDefaultSoundName;
            localNotice.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber]+1;
            [[UIApplication sharedApplication] presentLocalNotificationNow:localNotice];
            [application endBackgroundTask:taskId];
        });
    }];
     */
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
