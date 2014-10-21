//
//  BookInfo.h
//  YDReader
//
//  Created by sunlight on 14-10-11.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookInfo : NSObject

//书名
@property (copy,nonatomic) NSString *bookName;
//书的编号
@property (copy,nonatomic) NSString *bookCode;
//书的类型
@property (assign,nonatomic) YDBookType bookType;
//书的内容
@property (strong,nonatomic) NSString *bookContent;
//书的路径
@property (copy,nonatomic) NSString *bookPath;
//书的书签字符串标记
@property (copy,nonatomic) NSString *bookMarkStr;

@end
