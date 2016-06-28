//
//  HHTShiperExperienceApi.m
//  Shipping
//
//  Created by 朱彦君 on 16/6/2.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "HHTShiperExperienceApi.h"

@implementation HHTShiperExperienceApi{
    HHTShiperExperienceModel *_model;
}
- (instancetype)init
{
    if (self = [super init]) {
        _model = [[HHTShiperExperienceModel alloc]init];
    }
    return self;
}
- (NSString *)requestPathUrl{
    return @"/app/crewExperience";
}
- (NSDictionary *)requestParameter
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.crewId forKey:@"crewId"];
    return dic;
}
- (NSObject *)analysisModel{
    return _model;
}

- (NSArray <HHTShiperExperienceModelItems *>*)getItems{
    if (_model.code == 200) {
        NSLog(@"_model.data.items?_model.data.items =%@  cache = %@",[_model.data.items[0] shipTypeName],self.cacheJson);
        return  _model.data.items?_model.data.items:nil;
    }else{
        NSLog(@" %s%@",__PRETTY_FUNCTION__,_model.message);
        return nil;
    }
}
- (NSInteger)cacheTimeInSeconds {
    return 60 * 3;
}

@end
