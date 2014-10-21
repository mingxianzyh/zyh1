//
//  MoreBarViewController.h
//  CorePlotTest
//
//  Created by sunlight on 14-9-3.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface MoreBarViewController : UIViewController<CPTPlotSpaceDelegate,
CPTPlotDataSource,CPTBarPlotDelegate,CPTBarPlotDataSource,CPTBarPlotDelegate>

@end
