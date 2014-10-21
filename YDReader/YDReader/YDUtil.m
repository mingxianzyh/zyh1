//
//  YDUtil.m
//  YDReader
//
//  Created by sunlight on 14-10-11.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//
#define bookFolder @"BOOKS"

#import "YDUtil.h"

@implementation YDUtil

+ (NSString*)documentPath{

    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

+ (NSString*)documentBooksPath{
    return [[YDUtil documentPath] stringByAppendingPathComponent:bookFolder];
}

+ (NSArray*)allBooks{
    
    NSMutableArray *books = [[NSMutableArray alloc] init];
    NSString *booksPath = [self documentBooksPath];
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSError *error;
    NSArray *array = [fileManage contentsOfDirectoryAtPath:booksPath error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    if ([array count] > 0) {
        
    }
    return books;
}
@end
