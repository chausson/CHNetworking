//
//  SDUpdateProfileAPI.h
//  FrameWorkPractice
//
//  Created by Chausson on 16/5/27.
//  Copyright © 2016年 Chausson. All rights reserved.
//
#import "CHNetworking.h"
#import "SDBaseResponse.h"

@interface SDUpdateProfileAPI : CHNetRequest
+ (instancetype)new __unavailable;
- (instancetype)init  __unavailable;
- (instancetype)initWithProfile:(NSDictionary *)profile;

@property (nonatomic ,readonly ) SDBaseResponse *baseResponse;

@property (nonatomic ,readonly ) NSDictionary *profile;

@end
