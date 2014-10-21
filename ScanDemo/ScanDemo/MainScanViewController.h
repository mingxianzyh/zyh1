//
//  MainScanViewController.h
//  ScanDemo
//
//  Created by sunlight on 14-9-16.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MapKit/MapKit.h>

@interface MainScanViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate,CLLocationManagerDelegate>

@end
