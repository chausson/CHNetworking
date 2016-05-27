//
//  SDBaseResponse.h
//  FrameWorkPractice
//
//  Created by Chausson on 16/5/26.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDBaseResponse : NSObject

@property (nonatomic ,strong ) NSString *message;
@property (nonatomic ,strong ) NSDictionary *data;
@property (nonatomic ,assign ) NSInteger code;

- (instancetype)initWithJSON:(NSDictionary *)json;
@end
