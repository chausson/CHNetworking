//
//  CHNetworkPrivate.h
//  CHNetworkingDemo
//
//  Created by XiaoSong on 16/3/3.
//  Copyright © 2016年 CM. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CHDEPRECATED(_version) __attribute__((deprecated)) //弃用方法宏定义

FOUNDATION_EXPORT void CHLog(NSString *format, ...) NS_FORMAT_FUNCTION(1,2);
@interface CHNetworkPrivate : NSObject

//+ (NSString *)URLEncode:(NSString *)url;
+ (BOOL)checkJson:(id)json withValidator:(id)validatorJson;

+ (BOOL)checkJSONModelWithClass:(Class)cls;

+ (NSString *)dictionaryToJSONString:(NSDictionary *)parameter;

@end
