//
//  WSDStringUtils.m
//  NewInformationEnter
//
//  Created by sunlight on 14-4-11.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "WSDStringUtils.h"

@implementation WSDStringUtils

//判断是否字符串为空
+ (BOOL)isBlank:(NSString*)str{
    if (str==nil||[@"" isEqual:str]) {
        return YES;
    }else{
        return NO;
    }
    
}

//判断是否字符串不为空
+ (BOOL)isNotBlank:(NSString*)str{
    if (str==nil||[@"" isEqual:str]) {
        return NO;
    }else{
        return YES;
    }
}

//生成UUID
+ (NSString*)genUUID{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef= CFUUIDCreateString(NULL,uuidRef);
    CFRelease(uuidRef);
    //非ARC
    //NSString *retStr = [NSString stringWithString:(NSString *)uuidStrRef];
    //ARC(uuidStrRef交给ARC管理，无需手动释放)
    NSString *retStr = [NSString stringWithString:(__bridge_transfer NSString *)uuidStrRef];
    return retStr;
}

//判断字符串是否为整数
+ (BOOL)isNumber:(NSString*)str{
    
    BOOL flag = YES;
    if ([self isNotBlank:str]) {
        NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:WSD_NUMBERS];
        for (int i = 0 ; i < [str length]; i++) {
            NSString *singleStr = [str substringWithRange:NSMakeRange(i, 1)];
            NSRange range = [singleStr rangeOfCharacterFromSet:charSet];
            if (range.length == 0) {
                flag = NO;
                break;
            }
            //当字符超过两位的时候,第一个字符串不能为0
            if (i==0&&[str length]>1&&[WSD_ZERO isEqualToString:singleStr]) {
                flag = NO;
                break;
            }
        }
    }else{
        flag = NO;
    }
    return flag;
}

//判断字符串是否为小数(整数也可以)
+ (BOOL)isDecialNumber:(NSString*)str{
    
    BOOL flag = YES;
    if ([self isBlank:str]) {
        flag = NO;
        return flag;
    }
    //先判断是否为整数
    if ([self isNumber:str]) {
        return YES;
    }
    
    NSArray *array = [str componentsSeparatedByString: WSD_DECIMAL_POINT];
    if (array.count>2) {
        flag = NO;
        return flag;
    }
    
    NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:WSD_DOUBLE_NUMBERS];
    
    //剔除01.1/001.1的情况
    BOOL isFirstZero = NO;
    for (int i = 0 ; i < [str length]; i++) {
            
        NSString *singleStr = [str substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [singleStr rangeOfCharacterFromSet:charSet];
        if (range.length == 0) {
            flag = NO;
            break;
        }
        if (i==0&&[WSD_ZERO isEqualToString:singleStr]) {
            isFirstZero = YES;
        }
        //当第一位是0时，判断第二位是否为.(不为.则不是小数)
        if (i==1&&isFirstZero&&![WSD_DECIMAL_POINT isEqualToString:singleStr]) {
            flag = NO;
            break;
        }
        //第一个字符串和最后一个字符串不能为.
        if ((i==0||i==[str length]-1)&&[WSD_DECIMAL_POINT isEqualToString:singleStr]) {
            flag = NO;
            break;
        }
        
    }
    return flag;
}

//判断单字符串是否是数字类型(0123456789)
+ (BOOL)isMemeberOfNumber:(NSString*)singleStr{
    BOOL flag = YES;
    if ([self isNotBlank:singleStr]) {
        NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:WSD_NUMBERS];
        NSRange range = [singleStr rangeOfCharacterFromSet:charSet];
        if (range.length == 0) {
            flag = NO;
        }
    }else{
        flag = NO;
    }
    return flag;
}

//判断单字符串是否是小数类型(0123456789.)
+ (BOOL)isMemberOfDecialNumber:(NSString*)singleStr{
    BOOL flag = YES;
    if ([self isNotBlank:singleStr]) {
        NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:WSD_DOUBLE_NUMBERS];
        NSRange range = [singleStr rangeOfCharacterFromSet:charSet];
        if (range.length == 0) {
            flag = NO;
        }
    }else{
        flag = NO;
    }
    return flag;
}
@end
