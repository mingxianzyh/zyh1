//
//  MainViewController.h
//  push
//
//  Created by sunlight on 14-5-28.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface MainViewController : UIViewController<ASIHTTPRequestDelegate>

//注册token
- (void)registerToken:(NSString *)token;
//从后台加载数据
- (void)loadDataFromService;

@end
