//
//  ViewController.h
//  下拉刷新
//
//  Created by sunlight on 14-5-4.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//


typedef enum WSDViewIdentify{
    WSDHeaderViewIdentify = 0,
    WSDFooterViewIdentify

}WSDViewIdentify;

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "WSDRefreshFooterView.h"
#import "CustomTableView.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate,WSDRefreshTableFooterDelegate>

@end
