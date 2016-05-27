//
//  SDRegisterAPI.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/5/26.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "SDRegisterAPI.h"

@implementation SDRegisterAPI
- (instancetype)initWithAccount:(NSString *)account
                       password:(NSString *)password
                      phoneCode:(NSString *)code{
    self = [super init];
    if (self) {
        NSAssert(account.length > 0 && password.length > 0 && code.length > 0, @"account or password or code is nil");
        _code = code;
        _account = account;
        _password = password;
    }
    return self;
}
- (NSDictionary *)requestParameter{
    return @{@"cellphone":self.account,
             @"password":self.password,
             @"phoneCode":self.code};
}
- (CHRequestMethod)requestMethod{
    return CHRequestMethodPost;
}
- (NSString *)requestPathUrl{
    return @"/app/register";
}
- (void)requestCompletionBeforeBlock{
    _baseResponse = [[SDBaseResponse alloc]initWithJSON:self.response.responseJSONObject];
}
- (NSString *)token{
    
    if ([self.response.responseJSONObject objectForKey:@"data"] ) {
        return [self.response.responseJSONObject objectForKey:@"data"];
    }else{
        return nil;
    }
}
@end
