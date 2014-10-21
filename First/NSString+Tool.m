//
//  NSString+Tool.m
//  First
//
//  Created by sunlight on 14-3-4.
//  Copyright (c) 2014年 sunlight.wisdom. All rights reserved.
//

#import "NSString+Tool.h"

@implementation NSString (Tool)

+ (BOOL) isBlank : (NSString*) string{
    if(string == nil||string == NULL){
        return YES;
    }
    if([string isKindOfClass:[NSNull class]]){
        return YES;
    }
    if([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0){
        return YES;
    }
    
    return NO;
}
@end
