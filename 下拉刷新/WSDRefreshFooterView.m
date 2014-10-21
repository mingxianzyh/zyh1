//
//  WSDRefreshFooterView.m
//  NewInformationEnter
//
//  Created by sunlight on 14-4-18.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WSDRefreshFooterView.h"

#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f

@interface WSDRefreshFooterView (Private)
- (void)setState:(WSDPullRefreshState)aState;
@end
@implementation WSDRefreshFooterView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
        
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,10.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont systemFontOfSize:12.0f];
		label.textColor = TEXT_COLOR;
		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000
		label.textAlignment = NSTextAlignmentCenter;
#elif
        label.textAlignment = UITextAlignmentCenter;
#endif
		[self addSubview:label];
		_lastUpdatedLabel=label;
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,28.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont boldSystemFontOfSize:13.0f];
		label.textColor = TEXT_COLOR;
		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000
		label.textAlignment = NSTextAlignmentCenter;
#elif
        label.textAlignment = UITextAlignmentCenter;
#endif
		[self addSubview:label];
		_statusLabel=label;
		
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(25.0f,10.0f, 30.0f, 55.0f);
		layer.contentsGravity = kCAGravityResizeAspect;
		layer.contents = (id)[UIImage imageNamed:@"blueArrow.png"].CGImage;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			layer.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		
		[[self layer] addSublayer:layer];
		_arrowImage=layer;
		
		UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		view.frame = CGRectMake(25.0f,38.0f, 20.0f, 20.0f);
		[self addSubview:view];
		_activityView = view;
		
		
		[self setState:WSDPullRefreshNormal];
		
    }
	
    return self;
	
}


#pragma mark -
#pragma mark Setters

- (void)refreshLastUpdatedDate {
	
	if ([_delegate respondsToSelector:@selector(egoRefreshTableFooterDataSourceLastUpdated:)]) {
		
		NSDate *date = [_delegate egoRefreshTableFooterDataSourceLastUpdated:self];
		
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
		_lastUpdatedLabel.text = [NSString stringWithFormat:@"上次更新时间: %@", [formatter stringFromDate:date]];
//		[[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"WSDRefreshTableView_LastRefresh"];
//        //立即同步
//		[[NSUserDefaults standardUserDefaults] synchronize];
		
	} else {
		
		_lastUpdatedLabel.text = nil;
		
	}
    
}
//流程控制主方法
- (void)setState:(WSDPullRefreshState)aState{
	
	switch (aState) {
            //如果状态为释放刷新，设置显示的字体
		case WSDPullRefreshPulling:
			
			_statusLabel.text = @"释放刷新数据";
			[CATransaction begin];
			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
            _arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
			
			break;
            //如果状态为上拉刷新
		case WSDPullRefreshNormal:
			//当前状态为释放更新 (释放->上拉)说明一直在拖动，且不是加载状态箭头图片
			if (_state == WSDPullRefreshPulling) {
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
                _arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
				[CATransaction commit];
			}
			
			_statusLabel.text = @"上拉刷新数据";
			[_activityView stopAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			_arrowImage.hidden = NO;
            //图片旋转180度
			_arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];
			break;
            //如果当前状态为加载中
		case WSDPullRefreshLoading:
			
			_statusLabel.text = @"加载中...";
			[_activityView startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			_arrowImage.hidden = YES;
			[CATransaction commit];
			
			break;
		default:
			break;
	}
	
	_state = aState;
}
#pragma mark - Util
- (CGFloat)scrollViewOffsetFromBottom:(UIScrollView *) scrollView
{
    CGFloat scrollAreaContenHeight = scrollView.contentSize.height;
    
    CGFloat visibleTableHeight = MIN(scrollView.bounds.size.height, scrollAreaContenHeight);
    CGFloat scrolledDistance = scrollView.contentOffset.y + visibleTableHeight; // If scrolled all the way down this should add upp to the content heigh.
    
    CGFloat normalizedOffset = scrollAreaContenHeight -scrolledDistance;
    
    return normalizedOffset;
    
}

#pragma mark -
#pragma mark ScrollView Methods
//设置scrollView的委托方法，当scrollView滚动时候调用
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat bottomOffset = [self scrollViewOffsetFromBottom:scrollView];
    //如果当前的状态为加载中(加载中时滚动scrollView)
	if (_state == WSDPullRefreshLoading) {
        CGFloat offset = MAX(bottomOffset * -1, 0);
		offset = MIN(offset, 60.0F);
        UIEdgeInsets currentInsets = scrollView.contentInset;
        currentInsets.bottom = offset? offset + (scrollView.bounds.size.height - MIN(scrollView.bounds.size.height, scrollView.contentSize.height)): 0;
        scrollView.contentInset = currentInsets;
        
        //如果当前状态不是加载中，并且scrollView正在拖动
	} else if (scrollView.isDragging) {
		
        //判断是否在加载数据
		BOOL _loading = NO;
		if ([_delegate respondsToSelector:@selector(egoRefreshTableFooterDataSourceIsLoading:)]) {
			_loading = [_delegate egoRefreshTableFooterDataSourceIsLoading:self];
		}
        //这两种的状态为拖动状态，并且拖动并未结束时，数据不再加载中，处理文字以及图标的显示(以65为界限)
		//如果当前状态为释放刷新数据，当前下拉偏移量在0-65之间并且当前数据并不在加载状态，设置状态为上拉刷新
		if (_state == WSDPullRefreshPulling && bottomOffset > -65.0f && bottomOffset < 0.0f && !_loading) {
			[self setState:WSDPullRefreshNormal];
            //如果当前状态为上拉刷新，并且当前偏移量大于65，并且数据并不在加载，设置状态为释放刷新
		} else if (_state == WSDPullRefreshNormal && bottomOffset
                   <-65.0f && !_loading) {
			[self setState:WSDPullRefreshPulling];
		}
//        NSLog(@"%f",scrollView.contentInset.bottom);
//		//如果当前的inset边距不=0，则设置为0
//		if (scrollView.contentInset.bottom != 0) {
//            UIEdgeInsets currentInsets = scrollView.contentInset;
//            currentInsets.bottom = 0;
//            scrollView.contentInset = currentInsets;
//		}
		
	}
	
}
//设置scrollView的委托方法，当scrollView拖动结束时候调用
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
	
    //判断当前是否在加载数据
	BOOL _loading = NO;
	if ([_delegate respondsToSelector:@selector(egoRefreshTableFooterDataSourceIsLoading:)]) {
		_loading = [_delegate egoRefreshTableFooterDataSourceIsLoading:self];
	}
	//如果当前数据不在加载状态，并且偏移量大于65
    
	if ([self scrollViewOffsetFromBottom:scrollView] <= -65 && !_loading) {
		//先设置状态在加载数据
		//设置当前状态为加载中
		[self setState:WSDPullRefreshLoading];
        //设置scrollview距离边界的高度
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		[UIView commitAnimations];
        //调用委托，加载数据源
		if ([_delegate respondsToSelector:@selector(egoRefreshTableFooterDidTriggerRefresh:)]) {
			[_delegate egoRefreshTableFooterDidTriggerRefresh:self];
		}
	}
}

//刷新完数据后调用
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
	//完成加载后恢复正常
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
    UIEdgeInsets currentInsets = scrollView.contentInset;
    currentInsets.bottom = 0;
    scrollView.contentInset = currentInsets;
	[UIView commitAnimations];
	//设置状态为上拉刷新
	[self setState:WSDPullRefreshNormal];
    //调整frame位置(加载完以后footerView的frame Y需要改变)
    [self adjustFooterViewFrame:scrollView];
    
}
//调整frame位置
- (void)adjustFooterViewFrame:(UIScrollView *)scrollView{

    //内容的高度
    CGFloat contentHeight = scrollView.contentSize.height;
    //表格的高度
    CGFloat tableHeight = scrollView.frame.size.height - scrollView.contentInset.top - scrollView.contentInset.bottom;
    //y坐标
    CGFloat y = MAX(contentHeight, tableHeight);
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;

}
#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
	
	_delegate=nil;
	_activityView = nil;
	_statusLabel = nil;
	_arrowImage = nil;
	_lastUpdatedLabel = nil;
}
@end
