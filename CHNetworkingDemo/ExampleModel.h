//
//  ExampleModel.h
//  CHNetworkingDemo
//
//  Created by Chausson on 16/4/28.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "JSONModel.h"

@interface ExampleModel : JSONModel
@property (assign ,nonatomic) int code;
@property (strong ,nonatomic) NSString *message;
@end
