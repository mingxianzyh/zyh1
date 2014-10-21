//
//  WsdSegmentView.h
//  ViewTest
//
//  Created by sunlight on 14-5-12.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WsdSegmentView;
@protocol WsdSegmentDelegate <NSObject>

//代理方法，当选中segment时调用
- (void)wsdSegmentView:(WsdSegmentView *)wsdSegmentView DidSelectSegmentAtIndex:(NSInteger)index;
@end


@interface WsdSegmentView : UIView

- (id)initWithTitles:(NSArray *)titles;
//显示标题列表
@property (nonatomic,strong) NSArray *titles;
//代理
@property (nonatomic,weak) id<WsdSegmentDelegate> delegate;
@end
