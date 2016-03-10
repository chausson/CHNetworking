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

@property (strong, nonatomic,readonly) NSString *baseUrl;

@property (strong, nonatomic,readonly) NSDictionary *baseParameter;

@property (assign, nonatomic,readonly) NSInteger maxConcurrentOperationCount;

@property (assign, nonatomic,readonly) BOOL allowPrintLog; //  authorization to print log info defult = NO

- (void)setBaseUrl:(NSString *)baseUrl;

- (void)setBaseParameter:(NSDictionary *)baseParameter;

- (void)setAllowPrintLog:(BOOL )allowPrintLog;
/**
 *   @brief 设置允许同时最大并发数量，过大容易出问题, 默认3
 */
- (void)setMaxConcurrentOperationCount:(NSInteger)inter;
@end
