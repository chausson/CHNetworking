//
//  SDSendCodeAPI.h
//  FrameWorkPractice
//
//  Created by Chausson on 16/5/26.
//  Copyright © 2016年 Chausson. All rights reserved.
//
#import "CHNetworking.h"
#import "SDBaseRequest.h"

@interface SDSendCodeAPI : CHNetRequest
- (instancetype)init  __unavailable;
+ (instancetype)new __unavailable;

- (instancetype)initWithCellPhone:(NSString *)phone;

@property (nonatomic ,readonly ) SDBaseResponse *baseResponse;

@property (nonatomic ,readonly ) NSString *phone;

@end
