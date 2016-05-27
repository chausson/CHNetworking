//
//  SDForgetPasswordAPI.h
//  FrameWorkPractice
//
//  Created by Chausson on 16/5/26.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHNetworking.h"
#import "SDBaseResponse.h"

@interface SDForgetPasswordAPI : CHNetRequest

+ (instancetype)new __unavailable;
- (instancetype)init  __unavailable;
- (instancetype)initWithPassword:(NSString *)password
                   freshPassword:(NSString *)freshPassword;

@property (nonatomic ,readonly ) SDBaseResponse *baseResponse;

@property (nonatomic ,readonly ) NSString *password;

@property (nonatomic ,readonly ) NSString *freshPassword;

@end
