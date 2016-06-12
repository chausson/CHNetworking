//
//  HHTShiperExperienceModel.h
//  Shipping
//
//  Created by 朱彦君 on 16/6/2.
//  Copyright © 2016年 Chausson. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "JSONModel.h"
@class HHTShiperExperienceModelItems;
@protocol HHTShiperExperienceModelItems <NSObject>

@end
@interface HHTShiperExperienceModelItems : NSObject
@property (nonatomic , strong) NSString *displayOrder;
@property (nonatomic , strong) NSString *status;
@property (nonatomic , strong) NSString *createBy;
@property (nonatomic , strong) NSString *createTime;
@property (nonatomic , strong) NSString *updateBy;
@property (nonatomic , strong) NSString *updateTime;
@property (nonatomic , strong) NSString *version;
@property (nonatomic , strong) NSString *lastUpdate;
@property (nonatomic , strong) NSString *id;
@property (nonatomic , strong) NSString *crewId;
@property (nonatomic , strong) NSString *companyName;
@property (nonatomic , strong) NSString *entryDate;
@property (nonatomic , strong) NSString *rankId;
@property (nonatomic , strong) NSString *shipName;
@property (nonatomic , strong) NSString *shipTypeId;
@property (nonatomic , strong) NSString *dwt;
@property (nonatomic , strong) NSString *grossTonnage;
@property (nonatomic , strong) NSString *mainEngineType;
@property (nonatomic , strong) NSString *mainEnginePower;
@property (nonatomic , strong) NSString *remark;
@property (nonatomic , strong) NSString *companyId;
@property (nonatomic , strong) NSString *rankName;
@property (nonatomic , strong) NSString *shipTypeName;

@end


@interface HHTShiperExperienceModelData : NSObject
@property (nonatomic, strong) NSArray <HHTShiperExperienceModelItems *>*items;
@end

@interface HHTShiperExperienceModel : NSObject
@property (strong ,nonatomic) HHTShiperExperienceModelData *data;
@property (assign ,nonatomic) int code;
@property (copy ,nonatomic) NSString *message;
@end



