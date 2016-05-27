//
//  SDBaseResponse.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/5/26.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "SDBaseResponse.h"

@implementation SDBaseResponse
- (instancetype)initWithJSON:(NSDictionary *)json{
    self = [super init];
    if (self) {
        if (json) {
            if ([json objectForKey:@"message"]) {
                _message = [json objectForKey:@"message"];
            }
            if ([json objectForKey:@"code"]) {
                _code = [[json objectForKey:@"code"] integerValue];
            }
            if ([json objectForKey:@"data"]) {
                _data = [json objectForKey:@"data"];
            }
        }
    }
    return self;
}
@end
