//
//  RootViewController.h
//  LocationDemo
//
//  Created by sunlight on 14-3-26.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>
@interface RootViewController : UIViewController<CLLocationManagerDelegate>

@property (strong,nonatomic) CLLocationManager *locationManager;

@end
