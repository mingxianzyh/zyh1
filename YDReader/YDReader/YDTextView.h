//
//  YDTextView.h
//  YDReader
//
//  Created by sunlight on 14-10-13.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDTextView : UITextView

//当前页文字
- (NSString *)currentPageText;
//当前第几页
- (NSInteger)currentPageNum;
//总页数
- (NSInteger)totalPageCount;
//当前阅读百分比(0-1)
- (float) currentPercent;
@end
