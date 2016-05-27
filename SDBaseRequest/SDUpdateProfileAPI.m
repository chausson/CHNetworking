//
//  SDUpdateProfileAPI.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/5/27.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "SDUpdateProfileAPI.h"

@implementation SDUpdateProfileAPI
- (instancetype)initWithProfile:(NSDictionary *)profile{
    self = [super init];
    if (self) {
        NSParameterAssert(profile);
        _profile = profile;
    }
    return self;
}
- (NSDictionary *)requestParameter{
    return _profile;
}
- (CHRequestMethod)requestMethod{
    return CHRequestMethodPut;
}
- (NSString *)requestPathUrl{
    return @"/app/profile";
}
- (void)requestCompletionBeforeBlock{
    _baseResponse = [[SDBaseResponse alloc]initWithJSON:self.response.responseJSONObject];
}
// 拼装一个逛tv的测试token
//- (NSDictionary *)requestHeaderFieldValueDictionary{
//    return @{@"Cookie":@"token=9JRnMNa2iFB0BteGb%2FwXcQajKM%2BpTvwhkj%2Fnz6Ea7bzMjb%2Bkgfm1TCxFoeOFbjnZWmg%2BUkUyms%2Ftrpl2lsTWlFLjcjfkfFSLoZYK6wJu4lZg%2BcqOqT7GpKOtUC7%2BihLFd8mK%2FOiSpbAC5ERzgzUn%2FA%3D%3D"};
//}
@end
