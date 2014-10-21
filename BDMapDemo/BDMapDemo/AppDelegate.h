//
//  AppDelegate.h
//  BDMapDemo
//
//  Created by sunlight on 14-3-25.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{

@private
    BMKMapManager *_mapManager;
}

@property (strong, nonatomic) UIWindow *window;

@end
