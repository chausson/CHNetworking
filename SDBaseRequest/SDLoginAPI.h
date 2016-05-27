//
//  SDLoginAPI.h
//  FrameWorkPractice
//
//  Created by Chausson on 16/5/26.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHNetworking.h"
#import "SDBaseResponse.h"
@interface SDLoginAPI : CHNetRequest

+ (instancetype)new __unavailable;
- (instancetype)init  __unavailable;
- (instancetype)initWithAccount:(NSString *)account
                       password:(NSString *)password;

@property (nonatomic ,readonly ) SDBaseResponse *baseResponse;

@property (nonatomic ,readonly ) NSString *token;

@property (nonatomic ,readonly ) NSString *account;

@property (nonatomic ,readonly ) NSString *password;

@end
