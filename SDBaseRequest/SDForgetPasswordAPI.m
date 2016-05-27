//
//  SDForgetPasswordAPI.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/5/26.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "SDForgetPasswordAPI.h"

@implementation SDForgetPasswordAPI
- (instancetype)initWithPassword:(NSString *)password
                   freshPassword:(NSString *)freshPassword{
    self = [super init];
    if (self) {
        NSAssert(password.length > 0 && freshPassword.length > 0 , @"password or newpassword  is nil");
        _password = password;
        _freshPassword = freshPassword;
    }
    return self;
}
- (NSDictionary *)requestParameter{
    return @{@"password":self.password,
             @"newPassword":self.freshPassword
             };
}
- (CHRequestMethod)requestMethod{
    return CHRequestMethodPut;
}
- (NSString *)requestPathUrl{
    return @"/app/profile/password";
}
- (void)requestCompletionBeforeBlock{
    _baseResponse = [[SDBaseResponse alloc]initWithJSON:self.response.responseJSONObject];
}
@end
