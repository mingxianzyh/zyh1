//
//  SoapHelper.h
//  HttpRequest
//
//  Created by rang on 12-10-27.
//
//
#define DATABASE_NAME @"MyDataBase.sqlite"
#define defaultWebServiceNameSpace @"http://www.wisdom.sh.cn/"

#import <Foundation/Foundation.h>

@interface SoapHelper : NSObject
//默认soap信息
+(NSString*)defaultSoapMesage;
//生成soap信息
+(NSString*)methodSoapMessage:(NSString*)methodName;
+(NSString*)dicSoapMessage:(NSString*)dicKey;
+(NSString*)dicAllSoapMessage:(NSDictionary*)dic dicKey:(NSString*)dicKey;
+(NSString*)nameSpaceSoapMessage:(NSString*)space methodName:(NSString*)methodName;
//有参数soap生成
+(NSString*)arrayToDefaultSoapMessage:(NSArray*)arr methodName:(NSString*)methodName;
+(NSString*)arrayToNameSpaceSoapMessage:(NSString*)space params:(NSArray*)arr methodName:(NSString*)methodName;
@end
