//
//  CHNetworkConfig.m
//  CHNetworkingDemo
//
//  Created by XiaoSong on 16/3/3.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "CHNetworkConfig.h"
#import "CHNetworkPrivate.h"
@implementation CHNetworkConfig{
    
}
+ (CHNetworkConfig *)sharedInstance{
    static CHNetworkConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[self alloc]init];
        config->_maxConcurrentOperationCount = 3;
        config->_allowPrintLog = NO;
    });
    return config;
}

@end
