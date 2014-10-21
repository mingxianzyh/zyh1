#import "Jastor.h"
#import "JastorRuntimeHelper.h"
#import <objc/runtime.h>
#import <Foundation/Foundation.h>
@implementation Jastor

@synthesize objectId;
static NSString *idPropertyName = @"id";
static NSString *idPropertyNameOnObject = @"objectId";

Class nsDictionaryClass;
Class nsArrayClass;

//字典转换成对象（需要继承Jastor）
+ (id)objectFromDictionary:(NSDictionary*)dictionary AndClassName:(NSString *)className{
    id item = [[[NSClassFromString(className) alloc] initWithDictionary:dictionary] autorelease];
    return item;
}
//json转换成对象(需要继承Jastor)
+ (id)objectFormJson:(NSString *)json AndClassName:(NSString *)className{

    //获取NSData
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [data objectFromJSONData];
    Class class = NSClassFromString(className);
    //这里以后可以根据需要扩展出不需要继承Jastor的转换(利用反射与KVO)
    id object = [[class alloc] initWithDictionary:dic];
    return object;
}
-(id)init{
	if (!nsDictionaryClass) nsDictionaryClass = [NSDictionary class];
	if (!nsArrayClass) nsArrayClass = [NSArray class];
    if (self = [super init]) {
        
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
	if (!nsDictionaryClass) nsDictionaryClass = [NSDictionary class];
	if (!nsArrayClass) nsArrayClass = [NSArray class];
	
	if ((self = [super init])) {
		for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {

			id value = [dictionary valueForKey:key];
			
			if (value == [NSNull null] || value == nil) {
                continue;
            }
            
            if ([JastorRuntimeHelper isPropertyReadOnly:[self class] propertyName:key]) {
                continue;
            }
			
			// handle dictionary
			if ([value isKindOfClass:nsDictionaryClass]) {
				Class klass = [JastorRuntimeHelper propertyClassForPropertyName:key ofClass:[self class]];
				value = [[[klass alloc] initWithDictionary:value] autorelease];
			}
			// handle array
			else if ([value isKindOfClass:nsArrayClass]) {
                //改为当前类，如果当前类存在NAarray属性，则需要包含一个属性名_class的属性来标记当前NSArray为什么类别
//				Class arrayItemType = [[self class] performSelector:NSSelectorFromString([NSString stringWithFormat:@"%@_class", key])];
				Class arrayItemType = [self performSelector:NSSelectorFromString([NSString stringWithFormat:@"%@_class", key])];
				
				NSMutableArray *childObjects = [NSMutableArray arrayWithCapacity:[(NSArray*)value count]];
				
				for (id child in value) {
					if ([[child class] isSubclassOfClass:nsDictionaryClass]) {
                        //如果Dto存在相应的NSArray属性，也要重写initWithDictionary，并设置属性名_class方法
						Jastor *childDTO = [[[arrayItemType alloc] initWithDictionary:child] autorelease];
						[childObjects addObject:childDTO];
					} else {
						[childObjects addObject:child];
					}
				}
				
				value = childObjects;
			}
			// handle all others
			[self setValue:value forKey:key];
		}
		
		id objectIdValue;
		if ((objectIdValue = [dictionary objectForKey:idPropertyName]) && objectIdValue != [NSNull null]) {
			if (![objectIdValue isKindOfClass:[NSString class]]) {
				objectIdValue = [NSString stringWithFormat:@"%@", objectIdValue];
			}
			[self setValue:objectIdValue forKey:idPropertyNameOnObject];
		}
	}
	return self;	
}
-(BOOL)isExists:(NSString*)propertity{
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    BOOL isIn = NO;
    for(i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        if([propertity isEqualToString:(NSString*)property_getName(property) ]){
            isIn = YES;
            break;
        }
        
    }
    
    free(properties);
    return isIn;
}
/**
 只根据自定义类中的属性初始化
 **/
- (id)initWithDictionaryBySel:(NSDictionary *)dictionary {
	if (!nsDictionaryClass) nsDictionaryClass = [NSDictionary class];
	if (!nsArrayClass) nsArrayClass = [NSArray class];
	
	if ((self = [super init])) {
		for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
      
            id value = [dictionary valueForKey:key];
            
            if (value == [NSNull null] || value == nil) {
                continue;
            }
            
            if ([JastorRuntimeHelper isPropertyReadOnly:[self class] propertyName:key]) {
                continue;
            }
            
            // handle dictionary
            if ([value isKindOfClass:nsDictionaryClass]) {
                Class klass = [JastorRuntimeHelper propertyClassForPropertyName:key ofClass:[self class]];
                value = [[[klass alloc] initWithDictionary:value] autorelease];
            }
            // handle array
            else if ([value isKindOfClass:nsArrayClass]) {
                Class arrayItemType = [[self class] performSelector:NSSelectorFromString([NSString stringWithFormat:@"%@_class", key])];
                
                NSMutableArray *childObjects = [NSMutableArray arrayWithCapacity:[(NSArray*)value count]];
                
                for (id child in value) {
                    if ([[child class] isSubclassOfClass:nsDictionaryClass]) {
                        Jastor *childDTO = [[[arrayItemType alloc] initWithDictionaryBySel:child] autorelease];
                        [childObjects addObject:childDTO];
                    } else {
                        [childObjects addObject:child];
                    }
                }
                
                value = childObjects;
            }
            // handle all others
            [self setValue:value forKey:key];
            
		}
		
		id objectIdValue;
		if ((objectIdValue = [dictionary objectForKey:idPropertyName]) && objectIdValue != [NSNull null]) {
            
                if (![objectIdValue isKindOfClass:[NSString class]]) {
                    objectIdValue = [NSString stringWithFormat:@"%@", objectIdValue];
                }
                [self setValue:objectIdValue forKey:idPropertyNameOnObject];
            
		}
	}
	return self;
}

- (void)dealloc {
	self.objectId = nil;
	
//	for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
//		//[self setValue:nil forKey:key];
//	}
	
	[super dealloc];
}
-(NSString*) getJson:(Class) cClass{
    NSString *xml=@"";
    unsigned int outCount, i;
    if(cClass!=nil){
        objc_property_t *properties = class_copyPropertyList(cClass, &outCount);
        for(i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSString *key=[[[NSString alloc]initWithCString:property_getName(property) encoding:NSUTF8StringEncoding] autorelease];
            id value=[self  valueForKey:key];
            if (value!=nil) {            //IF NOT NSSTRING,LOOP!!!!!!
                Class valueClass =[value class];
                NSString *valueClassName = [valueClass description];
                
                if ([value isKindOfClass:[NSString class]]) {
                    xml=[xml stringByAppendingFormat:@"\"%@\":\"%@\",",key,value];
                }
                else if ([value isKindOfClass:nsDictionaryClass]) {// handle dictionary
                    xml=[xml stringByAppendingFormat:@"\"%@\":%@,",key,[[self valueForKey:key] toJson]];
                }
                else if ([value isKindOfClass:nsDictionaryClass]) {// handle dictionary
                    xml=[xml stringByAppendingFormat:@"\"%@\":%@,",key,[[self valueForKey:key] toJson]];
                }
                else if ([value isKindOfClass:[Jastor class]]) {// handle dictionary
                    xml=[xml stringByAppendingFormat:@"\"%@\":%@,",key,[[self valueForKey:key] toJson]];
                }
                // handle array
                else if ([value isKindOfClass:nsArrayClass]||[value isKindOfClass:[NSMutableArray class]]) {
                    //                Class arrayItemType = [[self class] performSelector:NSSelectorFromString([NSString stringWithFormat:@"%@_class", key])];
                    xml=[xml stringByAppendingFormat:@"\"%@\":[ ",key];
                    
                    for (id child in value) {
                        
                        xml=[xml stringByAppendingFormat:@"%@,",[child toJson]];
                        //                      NSLog(@"结果：%@",xml);
                    }
                    
                        xml=[xml substringToIndex:xml.length-1];
                    
                    
                    xml=[xml stringByAppendingFormat:@"],"];
                }
                else if ([valueClassName isEqualToString:@"__NSCFBoolean" ]) {// handle dictionary
                    NSString * boolResult = @"false";
                    if((Boolean)value==YES){
                        boolResult =@"true";
                    }
                    xml=[xml stringByAppendingFormat:@"\"%@\":%@,",key,boolResult];
                }
                else
                {
                    if(key==idPropertyNameOnObject){
                        xml=[xml stringByAppendingFormat:@"\"%@\":\"%@\",",idPropertyName,value];
                    }
                    else{
                        xml=[xml stringByAppendingFormat:@"\"%@\":%@,",key,value];
                    }
                    
                }
            }
            else
            {
                /**当属性为空时不序列化Json**/
                //            xml=[xml stringByAppendingFormat:@"\"%@\":\"%@\",",key,@""];
            }
        }
        if(cClass !=[Jastor class]){
            xml = [xml stringByAppendingFormat:@"%@",[self getJson:[cClass superclass]]];
        }
        free(properties);
    }
    return xml;
}
-(NSString *)toJson{
    NSString *xml=@"{";
    xml = [xml stringByAppendingFormat:@"%@",[self getJson:[self class]]];
    if(self.objectId!=nil){
        xml=[xml stringByAppendingFormat:@"%@:\"%@\",",idPropertyName,self.objectId];
    }
    xml=[xml substringToIndex:xml.length-1];
    xml=[xml stringByAppendingString:@"}"];
//    NSLog(@"结果：%@",xml);
//    free(properties);
    return xml;
}

- (void)encodeWithCoder:(NSCoder*)encoder {
	[encoder encodeObject:self.objectId forKey:idPropertyNameOnObject];
	for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
		[encoder encodeObject:[self valueForKey:key] forKey:key];
	}
}

+ (NSString *)converJsonFromObject:(id)object{

    NSMutableDictionary *returnDic = [[[NSMutableDictionary alloc] init] autorelease];
    NSArray *array =[JastorRuntimeHelper propertyNames:[object class]];//获取所有的属性名称
    for (NSString *key in array) {
        
        [returnDic setValue:[object valueForKey:key] forKey:key];//从类里面取值然后赋给每个值，取得字典
    }
    return  [returnDic JSONString];
}

- (NSString *)convertJsonFromObject{
    NSMutableDictionary *returnDic  =nil;
   returnDic = [[[NSMutableDictionary alloc] init] autorelease];
    
    NSArray *array =[JastorRuntimeHelper propertyNames:[self class]];//获取所有的属性名称
    
    for (NSString *key in array) {
        
        [returnDic setValue:[self valueForKey:key] forKey:key];//从类里面取值然后赋给每个值，取得字典
    }
    
    return  [returnDic JSONString] ;
}
- (id)initWithCoder:(NSCoder *)decoder {
	if ((self = [super init])) {
		[self setValue:[decoder decodeObjectForKey:idPropertyNameOnObject] forKey:idPropertyNameOnObject];
		
		for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
            if ([JastorRuntimeHelper isPropertyReadOnly:[self class] propertyName:key]) {
                continue;
            }
			id value = [decoder decodeObjectForKey:key];
			if (value != [NSNull null] && value != nil) {
				[self setValue:value forKey:key];
			}
		}
	}
	return self;
}

- (NSMutableDictionary *)toDictionary {
	NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.objectId) {
        [dic setObject:self.objectId forKey:idPropertyName];
    }
	
	for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
		id value = [self valueForKey:key];
        if (value && [value isKindOfClass:[Jastor class]]) {            
            [dic setObject:[value toDictionary] forKey:key];
        } else if (value && [value isKindOfClass:[NSArray class]] && ((NSArray*)value).count > 0) {
            id internalValue = [value objectAtIndex:0];
            if (internalValue && [internalValue isKindOfClass:[Jastor class]]) {
                NSMutableArray *internalItems = [NSMutableArray array];
                for (id item in value) {
                    [internalItems addObject:[item toDictionary]];
                }
                [dic setObject:internalItems forKey:key];
            } else {
                [dic setObject:value forKey:key];
            }
        } else if (value != nil) {
            [dic setObject:value forKey:key];
        }
	}
    return dic;
}

- (NSString *)description {
    NSMutableDictionary *dic = [self toDictionary];
	
	return [NSString stringWithFormat:@"#<%@: id = %@ %@>", [self class], self.objectId, [dic description]];
}

//- (BOOL)isEqual:(id)object {
//	if (object == nil || ![object isKindOfClass:[Jastor class]]) return NO;
//	
//	Jastor *model = (Jastor *)object;
//	
//	return [self.objectId isEqualToString:model.objectId];
//}

@end
