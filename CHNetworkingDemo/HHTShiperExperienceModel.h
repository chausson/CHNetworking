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
@interface HHTShiperExperienceModelItems : JSONModel
@property (nonatomic , strong) NSString <Optional>*displayOrder;
@property (nonatomic , strong) NSString <Optional>*status;
@property (nonatomic , strong) NSString <Optional>*createBy;
@property (nonatomic , strong) NSString <Optional>*createTime;
@property (nonatomic , strong) NSString <Optional>*updateBy;
@property (nonatomic , strong) NSString <Optional>*updateTime;
@property (nonatomic , strong) NSString <Optional>*version;
@property (nonatomic , strong) NSString <Optional>*lastUpdate;
@property (nonatomic , strong) NSString <Optional>*id;
@property (nonatomic , strong) NSString <Optional>*crewId;
@property (nonatomic , strong) NSString <Optional>*companyName;
@property (nonatomic , strong) NSString <Optional>*entryDate;
@property (nonatomic , strong) NSString <Optional>*rankId;
@property (nonatomic , strong) NSString <Optional>*shipName;
@property (nonatomic , strong) NSString <Optional>*shipTypeId;
@property (nonatomic , strong) NSString <Optional>*dwt;
@property (nonatomic , strong) NSString <Optional>*grossTonnage;
@property (nonatomic , strong) NSString <Optional>*mainEngineType;
@property (nonatomic , strong) NSString <Optional>*mainEnginePower;
@property (nonatomic , strong) NSString <Optional>*remark;
@property (nonatomic , strong) NSString <Optional>*companyId;
@property (nonatomic , strong) NSString <Optional>*rankName;
@property (nonatomic , strong) NSString <Optional>*shipTypeName;

@end


@interface HHTShiperExperienceModelData : JSONModel
@property (nonatomic, strong) NSArray <HHTShiperExperienceModelItems>*items;
@end

@interface HHTShiperExperienceModel : JSONModel
@property (strong ,nonatomic) HHTShiperExperienceModelData *data;
@property (assign ,nonatomic) int code;
@property (copy ,nonatomic) NSString *message;
@end



