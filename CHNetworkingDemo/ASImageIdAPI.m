//
//  ASImageIdAPI.m
//  ASNetworkingDemo
//
//  Created by XiaoSong on 16/3/4.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "ASImageIdAPI.h"
#import "ExampleModel.h"
@implementation ASImageIdAPI

- (NSString *)requestPathUrl{
    return @"/app/content?";
}
-(NSDictionary *)requestParameter{
    return @{@"type":@(0)};
}
- (NSArray *)getImageIds{
    ExampleModel *model = (ExampleModel *)self.response.serializerObject;
    NSLog(@"message = %@",model.message);
    return nil;
}
- (Class )responseModelClass{
    return [ExampleModel class];
}
@end
