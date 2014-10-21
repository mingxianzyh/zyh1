//
//  WsdScanViewController.h
//  ZBarTest
//
//  Created by sunlight on 14-9-11.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

//封装以后的ZBarVC
@interface WsdScanZbarViewController : ZBarReaderViewController

//UIInterfaceOrientationMask ZBarReaderViewController的supportedOrientationsMask 不起作用
@property (nonatomic,assign) UIInterfaceOrientationMask interfaceOrientationMasks;
//ipad default 400 other 280
@property (assign,nonatomic) float scanWidth;
//ipad default 400 other 400
@property (assign,nonatomic) float scanHeight;
@end
