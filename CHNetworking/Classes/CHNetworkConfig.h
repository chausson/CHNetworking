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

@property (strong, nonatomic) NSString *baseUrl;

@property (strong, nonatomic) NSDictionary *baseParameter;
/**
 *   @brief 设置允许同时最大并发数量，过大容易出问题, 默认3
 */
@property (assign, nonatomic) NSInteger maxConcurrentOperationCount;

@property (assign, nonatomic) BOOL allowPrintLog; //  authorization to print log info defult = NO

@end
