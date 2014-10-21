//
//  MapViewController.h
//  BDMapDemo
//
//  Created by sunlight on 14-3-25.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "BMapKit.h"

@interface MapViewController : UIViewController<BMKMapViewDelegate>

@property(strong,nonatomic) BMKAnnotationView *nowAnnotation;

@property(strong,nonatomic) BMKMapView *bmkMapView;

@property(strong,nonatomic) UIPopoverController *popViewController;
//用来进行第一次的加载标志
@property(assign,nonatomic) int index;

//点击相应经纬度范围内 弹出此view
@property(strong,nonatomic) UIView *labelView;



@end
