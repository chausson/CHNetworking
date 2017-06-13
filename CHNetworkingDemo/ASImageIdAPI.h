//
//  ASImageIdAPI.h
//  CHNetworkingDemo
//
//  Created by XiaoSong on 16/3/4.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "CHNetRequest.h"

@interface ASImageIdAPI : CHNetRequest
@property (assign ,nonatomic) NSInteger code;
- (NSArray *)getImageIds;

@end
