//
//  BookContentViewController.h
//  YDReader
//
//  Created by sunlight on 14-10-9.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookInfo.h"

@interface BookContentViewController : UIViewController


@property (strong,nonatomic) BookInfo *bookInfo;

- (instancetype)initWithBookInfo:(BookInfo *)book;

@end
