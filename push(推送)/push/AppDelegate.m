//
//  AppDelegate.m
//  push
//
//  Created by sunlight on 14-5-27.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@property (nonatomic,strong) MainViewController *mainViewController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //异步注册
    
    
    dispatch_queue_t queue = dispatch_queue_create("registerNotification", NULL);
    dispatch_async(queue, ^{
        //消息推送支持的类型
        UIRemoteNotificationType types =(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert);
        //注册消息推送
        [[UIApplication sharedApplication]registerForRemoteNotificationTypes:types];
    });
    MainViewController *mainController = [[MainViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:mainController];
    self.window.rootViewController = nc;
    self.mainViewController = mainController;
    //[self.mainViewController registerToken:@"74ba2ae76f62bda77322ed80baa44aebb9ac667be3abc2de2dbd1aaf05a202bd"];
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
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSLog(@"%@",deviceToken);
    //注册设备
    /*
    if (self.mainViewController) {
        NSString *token = [[[[NSString stringWithFormat:@"%@",deviceToken] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
        [self.mainViewController registerToken:token];
    }
    */
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"%@",error);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{

    NSLog(@"%@",userInfo);
}

@end
