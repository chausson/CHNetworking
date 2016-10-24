//
//  HHTShiperExperienceApi.h
//  Shipping
//
//  Created by 朱彦君 on 16/6/2.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHNetworking.h"
#import "HHTShiperExperienceModel.h"

@interface HHTShiperExperienceApi : CHNetRequest
@property (nonatomic, strong)NSString *crewId;
- (NSArray <HHTShiperExperienceModelItems *>*)getItems;


@end
