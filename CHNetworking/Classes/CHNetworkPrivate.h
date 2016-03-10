//
//  CHNetworkPrivate.h
//  CHNetworkingDemo
//
//  Created by XiaoSong on 16/3/3.
//  Copyright © 2016年 CM. All rights reserved.
//

#import <Foundation/Foundation.h>
FOUNDATION_EXPORT void CHLog(NSString *format, ...) NS_FORMAT_FUNCTION(1,2);
@interface CHNetworkPrivate : NSObject
//+ (NSString *)URLEncode:(NSString *)url;
+ (BOOL)checkJson:(id)json withValidator:(id)validatorJson;
@end
