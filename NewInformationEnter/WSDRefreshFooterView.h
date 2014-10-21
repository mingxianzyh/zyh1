//
//  WSDRefreshFooterView.h
//  NewInformationEnter
//
//  Created by sunlight on 14-4-18.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
	WSDPullRefreshPulling = 0,//释放刷新状态
	WSDPullRefreshNormal,//下拉刷新状态
	WSDPullRefreshLoading,//正在加载数据状态
} WSDPullRefreshState;

@protocol WSDRefreshTableFooterDelegate;

@interface WSDRefreshFooterView : UIView{
    
	WSDPullRefreshState _state;
	UILabel *_lastUpdatedLabel;
	UILabel *_statusLabel;
	CALayer *_arrowImage;
	UIActivityIndicatorView *_activityView;
}

//定义协议
@property(nonatomic,assign) id <WSDRefreshTableFooterDelegate> delegate;

//刷新更新时间
- (void)refreshLastUpdatedDate;
//在scrollView Delegate scrollViewDidScroll:中调用此方法
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
//在scrollView Delegate scrollViewDidEndDragging:中调用此方法
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
//完成数据加载进行一些UI显示处理工作
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;
@end

@protocol WSDRefreshTableFooterDelegate<NSObject>
//拖动完成时候时调用(在此委托中加载数据)
- (void)egoRefreshTableHeaderDidTriggerRefresh:(WSDRefreshFooterView*)view;
//返回数据是否在加载状态
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(WSDRefreshFooterView*)view;
@optional
//返回刷新时间时显示的时间
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(WSDRefreshFooterView*)view;

@end
