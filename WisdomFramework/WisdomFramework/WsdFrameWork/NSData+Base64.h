//
//  NSData+Base64.h
//  SupplierQuestionnaire
//
//  Created by sunlight on 14-7-11.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//
// IOS7以上 ios已经支持
#import <Foundation/Foundation.h>

@interface NSData (Base64)

+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)base64EncodedString;

@end
