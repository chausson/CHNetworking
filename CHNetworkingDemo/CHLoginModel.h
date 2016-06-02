//
//  CHLoginModel.h
//  CHNetworkingDemo
//
//  Created by Chausson on 16/6/2.
//  Copyright © 2016年 CM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHLoginModel : NSObject
@property (assign , nonatomic)  int code;
@property (strong , nonatomic)  NSString *message;
@property (strong , nonatomic)  NSString *data;
@end
