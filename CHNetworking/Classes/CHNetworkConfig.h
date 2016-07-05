//
//  CHNetworkConfig.h
//  CHNetworkingDemo
//
//  Created by XiaoSong on 16/3/3.
//  Copyright © 2016年 CM. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CHNetworkConfig : NSObject
+ (CHNetworkConfig *)sharedInstance;

@property (copy, nonatomic) NSString *baseUrl;
/**
 *   @brief 公共的参数数组
 */
@property (strong, nonatomic ,readonly) NSArray <NSDictionary *>*baseParameters;

@property (strong, nonatomic ,readonly) NSArray <NSDictionary *>*headerFieldParameters;
/**
 *   @brief 设置允许同时最大并发数量，过大容易出问题, 默认3
 */
@property (assign, nonatomic) NSInteger maxConcurrentOperationCount;

/**
 *   @brief 全局缓存的时间,当大于0时才有效,默认为-1
 */
@property (assign, nonatomic) NSInteger cacheTimeInSeconds;
/**
 *   @brief 全局开启打印Request的日志,默认不开启
 */
@property (assign, nonatomic) BOOL allowPrintLog;
/**
 *   @brief 添加公共的参数数组
 */
- (void)addBaseParameter:(NSDictionary *)parameter;
- (void)addheaderFieldParameter:(NSDictionary *)parameter;
- (void)clearHeaderFiled;
- (void)clearRequestCache;
@end
