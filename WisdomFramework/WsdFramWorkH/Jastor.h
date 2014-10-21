//
//  Jastor.h
//  Jastor
//
#import "JSONKit.h"
@interface Jastor : NSObject <NSCoding>

@property (nonatomic, copy) NSString *objectId;

//字典转换成对象（需要继承Jastor）
+ (id)objectFromDictionary:(NSDictionary*)dictionary AndClassName:(NSString *)className;
//json转换成对象(需要继承Jastor)
+ (id)objectFormJson:(NSString *)json AndClassName:(NSString *)className;
//对象转换成json(扩展)
+ (NSString *)converJsonFromObject:(id)object;


- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)initWithDictionaryBySel:(NSDictionary *)dictionary;
//转换成字典
- (NSMutableDictionary *)toDictionary;
- (NSString*)convertJsonFromObject;
//转换成json
- (NSString *)toJson;
@end
