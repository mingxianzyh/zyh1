//
//  MainViewController.m
//  MapKitDemo
//
//  Created by sunlight on 14-3-26.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import "MainViewController.h"
#import "MyAnnotation.h"
@interface MainViewController ()

@end

@implementation MainViewController

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
    // Do any additional setup after loading the view from its nib.
    
    //设置委托
    self.mapView.delegate = self;
    //显示地图类型
    self.mapView.mapType = MKMapTypeStandard;
    //设置经纬度坐标
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(31.2,121.44);
    //相对中心点的区域范围，数值越大 精度越小
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    //设置显示的区域
    MKCoordinateRegion region = MKCoordinateRegionMake(location, span);
    [self.mapView setRegion:region animated:YES];
    
    MyAnnotation *annotation = [[MyAnnotation alloc] init];
    
    annotation.title = @"MyAnnotation";
    annotation.subtitle = @"detailAnnotation";
    annotation.coordinate = CLLocationCoordinate2DMake(30.2, 120.44);
    //自定义属性
    annotation.index = 0;
    
    [self.mapView addAnnotation:annotation];

}

// mapView:viewForAnnotation: provides the view for each annotation.
// This method may be called for all or some of the added annotations.
// For MapKit provided annotations (eg. MKUserLocation) return nil to use the MapKit provided annotation view.
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    static NSString *Identify = @"MyAnnotation";
    
    if([annotation isMemberOfClass:[MyAnnotation class]]){
        
        MKPinAnnotationView *view = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:Identify];
        
        if(view == nil){
            view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:Identify];
            view.canShowCallout = YES;
            view.draggable = YES;
            view.animatesDrop = YES;
            view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        }
        view.annotation = annotation;
        return view;
    }else{
        return nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
