//
//  ASImageIdAPI.m
//  ASNetworkingDemo
//
//  Created by XiaoSong on 16/3/4.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "ASImageIdAPI.h"

@implementation ASImageIdAPI

- (NSString *)requestPathUrl{
    return @"/phone/getBatchImageIds.ep";
}
-(NSDictionary *)requestParameter{
    return @{@"imageIdCount":@(2)};
}
- (NSArray *)getImageIds{
    return self.response.responseJSONObject[@"imageIds"];
}
@end
