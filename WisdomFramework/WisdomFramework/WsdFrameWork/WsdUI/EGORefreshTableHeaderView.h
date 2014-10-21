//
//  CustomTableViewCell.h
//  NewInformationEnter
//
//  Created by sunlight on 14-4-1.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum{
	EGOOPullRefreshPulling = 0,//释放刷新状态
	EGOOPullRefreshNormal,//下拉刷新状态
	EGOOPullRefreshLoading,//正在加载数据状态
} EGOPullRefreshState;

@protocol EGORefreshTableHeaderDelegate;
@interface EGORefreshTableHeaderView : UIView {
	
	EGOPullRefreshState _state;
	UILabel *_lastUpdatedLabel;
	UILabel *_statusLabel;
	CALayer *_arrowImage;
	UIActivityIndicatorView *_activityView;
	

}

@property (nonatomic,assign) id <EGORefreshTableHeaderDelegate> delegate;

@property (nonatomic,copy) NSString *headerLoadingText;
@property (nonatomic,copy) NSString *pullUpText;
//是否显示加载日期
@property (nonatomic,assign) BOOL isShowRefreshDate;

//刷新更新时间
- (void)refreshLastUpdatedDate;
//在scrollView Delegate scrollViewDidScroll:中调用此方法
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
//在scrollView Delegate scrollViewDidEndDragging:中调用此方法
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
//完成数据加载进行一些UI显示处理工作
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end
@protocol EGORefreshTableHeaderDelegate<NSObject>
//拖动完成时候时调用(在此委托中加载数据)
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view;
//返回数据是否在加载状态
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view;
@optional
//返回刷新时间时显示的时间
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view;
@end
