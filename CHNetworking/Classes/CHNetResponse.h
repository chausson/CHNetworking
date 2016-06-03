//
//  CHNetResponse.h
//  CHNetworkingDemo
//
//  Created by XiaoSong on 16/3/3.
//  Copyright © 2016年 CM. All rights reserved.
//

#import <Foundation/Foundation.h>
@class serializerClass;
@protocol serializerClass <NSObject>
@end
@interface CHNetResponse : NSObject

- (instancetype)initWithSession:(NSURLSessionDataTask *)session andCallBackData:(id)data;

@property (readonly)  NSUInteger  taskIdentifier;/* an identifier for this task, assigned by and unique*/

@property (readonly)  NSUInteger  statusCode;/* an StatusCode for this Request*/

@property (readonly, strong) id responseJSONObject;/* an responseData With JSON for this Request if type is JSON*/

@property (readonly, strong) NSDictionary *allHeaderFields;

@property (readonly, strong) NSData *responseData;

@property (readonly, strong) NSURL *responseURL;

@property (readonly, strong) NSObject *responseObject;/* 通过Class获取解析完的对象*/

@property (readonly, strong) NSError *error;

@property (readonly, assign) Class serializerClass;

- (void)setSerializerClass:(Class )obj;
- (void)setResponseObj:(NSObject *)responseObject;

@end
