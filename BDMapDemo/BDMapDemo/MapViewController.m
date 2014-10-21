//
//  MapViewController.m
//  BDMapDemo
//
//  Created by sunlight on 14-3-25.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import "MapViewController.h"
#import "BMapKit.h"
#import "OffLineViewController.h"

@interface MapViewController ()

@property (nonatomic,strong) BMKGroundOverlay *groundOverlay;

@property (nonatomic,strong) OffLineViewController *offLineController;

@end

@implementation MapViewController

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
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.backBarButtonItem.title = @"退回";
    
    _bmkMapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    //_bmkMapView.showsUserLocation = YES;
    _bmkMapView.userTrackingMode = BMKUserTrackingModeFollow;
    self.view = _bmkMapView;
    
    UIBarButtonItem *addImageButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"增加自定义图片" style:UIBarButtonItemStyleBordered target:self action:@selector(addImage)];
    UIBarButtonItem *circleButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"增加自定义圆" style:UIBarButtonItemStyleBordered target:self action:@selector(addCircle)];
    UIBarButtonItem *tipButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"增加标注" style:UIBarButtonItemStyleBordered target:self action:@selector(addPopover:)];
    UIBarButtonItem *commonButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"我的位置" style:UIBarButtonItemStyleBordered target:self action:@selector(locate:)];
    UIBarButtonItem *offLine = [[UIBarButtonItem alloc] initWithTitle: @"离线地图" style:UIBarButtonItemStyleBordered target:self action:@selector(offLineNavigation)];
    //从右向左排列
    NSArray *buttonItems = @[offLine,addImageButtonItem,circleButtonItem,tipButtonItem,commonButtonItem];
    self.navigationItem.rightBarButtonItems = buttonItems;
    
    //初始化pop控制器
    self.popViewController = [[UIPopoverController alloc] initWithContentViewController:[[UIViewController alloc] init]];
    //百度SDK 委托中包含的单击事件
//    //增加单击手势识别器
//    UITapGestureRecognizer *tapGestureRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSingleTapView:)];
//    tapGestureRecongnizer.numberOfTapsRequired = 1;
//    
//    //增加双击识别器(如果不增加，则双击时会触发两次单击事件)
//    UITapGestureRecognizer *doubleTapGestureRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleTapView)];
//    doubleTapGestureRecongnizer.numberOfTapsRequired = 2;
//    
//    //设置双击时不会触发单击事件(当前当前识别器需要被处理为失败当触发了双击识别器)
//    [tapGestureRecongnizer requireGestureRecognizerToFail:doubleTapGestureRecongnizer];
//
//    [self.view addGestureRecognizer:tapGestureRecongnizer];
//    [self.view addGestureRecognizer:doubleTapGestureRecongnizer];
    CLLocationCoordinate2D cll2D =  CLLocationCoordinate2DMake(31.2798130f,121.503734f);
    UIImage *image = [UIImage imageNamed:@"1"];
    //图片描点(左上角)
    CGPoint anchor = CGPointMake(0.0,0.0);
    BMKGroundOverlay *groundOverlay = [BMKGroundOverlay groundOverlayWithPosition:cll2D zoomLevel:19 anchor:anchor icon:image];
    self.groundOverlay = groundOverlay;
    [_bmkMapView addOverlay:groundOverlay];
    
    BMKCoordinateSpan span;
    span.latitudeDelta = 0.0;
    span.longitudeDelta = 0.0;
    BMKCoordinateRegion region = BMKCoordinateRegionMake(cll2D, span);
    [_bmkMapView setRegion:[_bmkMapView regionThatFits:region] animated:YES];
    _bmkMapView.zoomLevel = 19;
    
    OffLineViewController *controller = [[OffLineViewController alloc] init];
    self.offLineController = controller;
}

#pragma self method mark begin
//增加自定义圆
- (void)addCircle{
    
    CLLocationCoordinate2D location = _bmkMapView.centerCoordinate;
    [_bmkMapView addOverlay:[BMKCircle circleWithCenterCoordinate:location radius:20]];
    
}

//增加自定义图片
- (void)addImage{
    
    CLLocationCoordinate2D cll2D =  _bmkMapView.centerCoordinate;
    CGPoint point = CGPointMake(0.0, 0.0);
    BMKGroundOverlay *groundOverlay = [BMKGroundOverlay groundOverlayWithPosition:cll2D zoomLevel:19 anchor:point icon:[UIImage imageNamed:@"1"]];
    [_bmkMapView addOverlay:groundOverlay];
    
}

- (void)offLineNavigation{

    [self.navigationController pushViewController:self.offLineController animated:YES];

}
#pragma self method mark end

//点击地图上包含文字和其他地图时触发
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi *)mapPoi{

//    if ([_labelView isHidden]) {
//        CGPoint point = [mapView convertCoordinate:mapPoi.pt toPointToView:mapView];
//        _labelView.frame = CGRectMake(point.x-20, point.y-20, 40, 40);
//        [_labelView setHidden:NO];
//    }else{
//        [_labelView setHidden:YES];
//    }
    NSLog(@"%@",mapPoi.text);
    [self popAreaView:mapPoi.pt];
}

//点击地图空白处(没有文字和图标时)回调
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate{
    [self popAreaView:coordinate];
//    if ([_labelView isHidden]) {
//        CGPoint point = [mapView convertCoordinate:coordinate toPointToView:mapView];
//        _labelView.frame = CGRectMake(point.x-20, point.y-20, 40, 40);
//        [_labelView setHidden:NO];
//    }else{
//        [_labelView setHidden:YES];
//    }
}

- (void)popAreaView:(CLLocationCoordinate2D) coordinate{
    
    CLGeocoder *geocder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    NSLog(@"经度:%f",coordinate.longitude);
    NSLog(@"维度:%f",coordinate.latitude);
    NSLog(@"水平精度:%f",location.horizontalAccuracy);
    NSLog(@"获取时间:%@",location.timestamp);
    [geocder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *place = placemarks[0];
        if (place.name != nil) {
            //有时候会显示简称
            NSLog(@"name:%@",place.name);
            //国家
            NSLog(@"country:%@",place.country);
            //行政区域(不会为null)显示省和直辖市 eg:江西省/上海市
            NSLog(@"administrativeArea:%@",place.administrativeArea);
            //一级市(直辖市的话，为null) eg:景德镇市
            NSLog(@"locality:%@",place.locality);
            //二级市/县/区  eg:珠山区/金山区/乐平市
            NSLog(@"subLocality:%@",place.subLocality);
            //街道名称 eg:常德路
            NSLog(@"thoroughfare:%@",place.thoroughfare);
            //子街道名称 eg:633弄
            NSLog(@"subThoroughfare:%@",place.subThoroughfare);
            
            NSLog(@"subAdministrativeArea:%@",place.subAdministrativeArea);
            NSLog(@"postalCode:%@",place.postalCode);
            //国家编码  eg:CN
            NSLog(@"ISOcountryCode:%@",place.ISOcountryCode);
            NSLog(@"inlandWater:%@",place.inlandWater);
            NSLog(@"ocean:%@",place.ocean);
            NSLog(@"areasOfInterest:%@",place.areasOfInterest);
            
            NSLog(@"addressDictionary:%@",place.addressDictionary);
            NSString *message = nil;
            if ([@"上海市" isEqualToString:place.administrativeArea ]) {
                
                message = [NSString stringWithFormat:@"你找到了-----%@%@",place.administrativeArea,place.subLocality];
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alertView show];
            }else{
                message = [NSString stringWithFormat:@"%@-%@",place.country,place.administrativeArea];
                if (place.locality) {
                    message = [message stringByAppendingString:[@"-" stringByAppendingString:place.locality]];
                }
                message = [message stringByAppendingString:[@"-" stringByAppendingString:place.subLocality]];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alertView show];
            }

        }
        
    }];
    
//    CGPoint point = [_bmkMapView convertCoordinate:coordinate toPointToView:_bmkMapView];
//    UIViewController *controller = [[UIViewController alloc] init];
//    controller.view.backgroundColor = [UIColor redColor];
//    self.popViewController.contentViewController = controller;
//    [self.popViewController presentPopoverFromRect:CGRectMake(point.x, point.y, 100, 100) inView:_bmkMapView permittedArrowDirections:UIPopoverArrowDirectionUp
//                                          animated:YES];
    
}

/**
 *根据overlay生成对应的View
 *@param mapView 地图View
 *@param overlay 指定的overlay
 *@return 生成的覆盖物View
 */
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{

    if ([overlay isKindOfClass:[BMKCircleView class]]) {
        BMKCircleView *overlayView = [[BMKCircleView alloc] initWithOverlay:overlay];
        overlayView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
        overlayView.strokeColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
        overlayView.lineWidth = 5;
        return overlayView;
    }else{
        BMKGroundOverlayView *groundOverlayView = [[BMKGroundOverlayView alloc] initWithOverlay:overlay];
        return groundOverlayView;
    }
}


//增加一个Annotation
- (void)addPopover:(UIBarButtonItem *) buttonItem{
    
    BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc] init];
    pointAnnotation.coordinate = _bmkMapView.centerCoordinate;
    pointAnnotation.title = @"first Annotation";
    pointAnnotation.subtitle = @"detailTitile";
    [_bmkMapView addAnnotation:pointAnnotation];
    
}
/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    
    static NSString *AnnotationViewID = @"renameMark";
    
    //Annotation复用
    BMKPinAnnotationView *pinView = (BMKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (pinView == nil) {
        pinView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        //是否设置从天而降的效果
        pinView.animatesDrop = YES;
        //是否可以拖拽
        pinView.draggable = YES;
        //设置大头针的颜色
        //红色
        //pinView.pinColor = BMKPinAnnotationColorRed;
        //绿色
        //pinView.pinColor = BMKPinAnnotationColorGreen;
        //紫色
        //pinView.pinColor = BMKPinAnnotationColorPurple;
        
        //这里可以替换大头针的图片
        pinView.image = [UIImage imageNamed:@"1"];
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        leftView.backgroundColor = [UIColor redColor];
        //设置点击大头针弹出视图的 左边的视图
        pinView.leftCalloutAccessoryView =leftView;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@"delete" forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 20, 20);
        //设置点击按钮以后删除这个标志view
        [button addTarget:self action:@selector(removeSelfAnnotation) forControlEvents:UIControlEventTouchUpInside];
        //设置点击大头针弹出视图的 右边的视图
        pinView.rightCalloutAccessoryView =button;
        
        UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        label.tag = 101;
        BMKActionPaopaoView *paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:mainView];
        pinView.paopaoView = paopaoView;
        pinView.calloutOffset = CGPointMake(0, -20);
        
    }
    pinView.annotation = annotation;
    return pinView;
}

- (void)removeSelfAnnotation{
    if(_nowAnnotation){
        [self.bmkMapView removeAnnotation:self.nowAnnotation.annotation];
        //可以根据这个titile去删除保存的数据
        //BMKPointAnnotation *pointAnnotation = self.nowAnnotation.annotation;
    }
}
/**
 *当选中一个annotation views(大头针标注图标)时，调用此接口
 *@param mapView 地图View
 *@param views 选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    self.nowAnnotation = view;
}

/**
 *定位当前位置时调用
 */
- (void)locate:(UIBarButtonItem *) buttonItem{
    
    _bmkMapView.showsUserLocation = NO;
    _bmkMapView.userTrackingMode = BMKUserTrackingModeFollow;
    _bmkMapView.showsUserLocation = YES;
    [self regionLocation];
}

/**
 *将当前地图窗口移动到用户所在区域
 */
- (void)regionLocation{
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(_bmkMapView.userLocation.coordinate, BMKCoordinateSpanMake(0.1, 0.1));
    BMKCoordinateRegion region = [_bmkMapView regionThatFits:viewRegion];
    [_bmkMapView setRegion:region animated:YES];
}

#pragma delegete
/**
 *用户位置更新后，会调用此函数
 *@param mapView 地图View
 *@param userLocation 新的用户位置
 */
-(void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation{
    if(_index==0){
        [self regionLocation];
        _index=1;
    }
    //NSLog(@"%f",userLocation.location.coordinate.latitude);//经度
    //NSLog(@"%f",userLocation.location.coordinate.longitude);//纬度
    //mapView.showsUserLocation = NO;

}

/**
 *地图区域改变完成后会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    //移除图层(同理可以移动注解)
    if (mapView.zoomLevel != 19.0) {
        [mapView removeOverlay:self.groundOverlay];
    }else{
        if (self.groundOverlay) {
            [mapView addOverlay:self.groundOverlay];
        }
    }
}




- (void)viewWillAppear:(BOOL)animated{
    
    [_bmkMapView viewWillAppear];
    _bmkMapView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated{
    //初始加载一个显示明细View
    self.labelView = [[UIView alloc] init];
    self.labelView.backgroundColor = [UIColor redColor];
    self.labelView.frame = CGRectMake(100, 100, 40, 40);
    [self.view addSubview:self.labelView];

}

- (void)viewWillDisappear:(BOOL)animated{
    [_bmkMapView viewWillDisappear];
    //释放内存
    _bmkMapView.delegate = nil;
    self.labelView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
