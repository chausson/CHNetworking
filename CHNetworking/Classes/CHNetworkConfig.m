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
    NSMutableArray <NSDictionary *>*_baseArray;
    NSMutableArray <NSDictionary *>*_headerFieldArray;
}
+ (CHNetworkConfig *)sharedInstance{
    static CHNetworkConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[self alloc]init];
        config->_maxConcurrentOperationCount = 3;
        config->_allowPrintLog = NO;
        config->_headerFieldArray = [NSMutableArray array];
    });
    return config;
}
- (void)addBaseParameter:(NSDictionary *)parameter{
    NSAssert([parameter isKindOfClass:[NSDictionary class]], @"Error! addBaseParameter Paramerter is not request class");
    [_baseArray addObject:parameter];

}
- (void)addheaderFieldParameter:(NSDictionary *)parameter{
    NSAssert([parameter isKindOfClass:[NSDictionary class]], @"Error! addBaseParameter Paramerter is not request class");
    [_headerFieldArray addObject:parameter];
}
- (NSArray <NSDictionary *>*)baseParameters{
    return [_baseArray copy];
    
}
- (NSArray <NSDictionary *>*)headerFieldParameters{
    return [_headerFieldArray copy];
    
}
@end
