//
//  SDLoginAPI.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/5/26.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "SDLoginAPI.h"

@implementation SDLoginAPI
- (instancetype)initWithAccount:(NSString *)account
                       password:(NSString *)password{
    self = [super init];
    if (self) {
        NSAssert(account.length > 0 && password.length > 0, @"account or password is nil");

        _account = account;
        _password = password;
    }
    return self;
}
- (NSDictionary *)requestParameter{
    return @{@"username":self.account,
             @"password":self.password};
}
- (CHRequestMethod)requestMethod{
    return CHRequestMethodPost;
}
- (NSString *)requestPathUrl{
    return @"/app/auth/login";
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
