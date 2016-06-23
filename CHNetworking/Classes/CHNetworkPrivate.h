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

+ (BOOL)checkJSONModel:(id )obj; // 判断是不是JSONModel

+ (NSString *)dictionaryToJSONString:(NSDictionary *)parameter;

+ (NSString *)clientVersion;

+ (NSString *)md5FromString:(NSString *)string;

/// NSURLIsExcludedFromBackupKey，注明不备份
+ (void)cancelBackupFileAtICloud:(NSString *)path;
/**
 * @brief 用CHModel和JSONModel解析模型
 * @param JSON 数据
 * @param 解析的对象
 * @return 如果有返回对象
 */

+ (void)analysisJSONWithDict:(NSDictionary*)dic toModel:(NSObject *)model;

@end
