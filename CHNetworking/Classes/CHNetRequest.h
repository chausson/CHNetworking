//
//  CHNetRequest.h
//  CHNetworkingDemo
//
//  Created by XiaoSong on 16/3/3.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "CHBaseRequest.h"

@interface CHNetRequest : CHBaseRequest

@property (nonatomic ,assign ,getter=isIgnoreCache) BOOL ignoreCache;

// 缓存数据
- (id)cacheJson;

/// 是否需要更新缓存
- (BOOL)isCacheNeedUpdate;

/// 是否当前的数据从缓存获得
- (BOOL)isDataFromCache;

/// 手动更新缓存
- (void)startWithoutCache;

- (NSInteger)cacheTimeInSeconds;

- (long long)cacheVersion;
// 解析模型
- (NSObject *)analysisModel;

@end
