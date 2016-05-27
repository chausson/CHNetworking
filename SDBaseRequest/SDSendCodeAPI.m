//
//  SDSendCodeAPI.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/5/26.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "SDSendCodeAPI.h"

@implementation SDSendCodeAPI
- (instancetype)initWithCellPhone:(NSString *)phone{
    self = [super init];
    if (self) {
        NSAssert(phone.length > 0, @"phone is nil");
        _phone = phone;
    }
    return self;
}
- (NSDictionary *)requestParameter{
    return @{@"cellphone":_phone};
}
- (CHRequestMethod)requestMethod{
    return CHRequestMethodPost;
}
- (NSString *)requestPathUrl{
    return @"/phoneCode/single";
}
- (void)requestCompletionBeforeBlock{
    _baseResponse = [[SDBaseResponse alloc]initWithJSON:self.response.responseJSONObject];
}
@end
