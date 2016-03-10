//
//  CHNetworkAgent.h
//  CHNetworkingDemo
//
//  Created by XiaoSong on 16/3/3.
//  Copyright © 2016年 CM. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CHBaseRequest;
@interface CHNetworkAgent : NSObject

+ (CHNetworkAgent *)sharedInstance;

- (void)addRequest:(CHBaseRequest *)request;

- (void)cancelRequest:(CHBaseRequest *)request;

@end
