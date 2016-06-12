//
//  CHModelObject.h
//  CHNetworkingDemo
//
//  Created by Chausson on 16/6/12.
//  Copyright © 2016年 CM. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CHModelObject <NSObject>

+ (instancetype)CH_modelWithDictionary:(NSDictionary *)dictionary; // chmodel解析

- (instancetype)initWithDictionary:(NSDictionary*)dict error:(NSError**)err; // jsonmodel解析

@end
