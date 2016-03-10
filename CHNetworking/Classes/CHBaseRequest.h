//
//  CHBaseRequest.h
//  CHNetworkingDemo
//
//  Created by XiaoSong on 16/3/3.
//  Copyright © 2016年 CM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "CHNetResponse.h"
typedef NS_ENUM(NSInteger , CHRequestMethod) {
    CHRequestMethodGet ,
    CHRequestMethodPost,
    CHRequestMethodPut,
};

typedef NS_ENUM(NSInteger , CHRequestSerializerType) {
    CHRequestSerializerTypeJSON,
    CHRequestSerializerPlainText,
};
typedef NS_ENUM(NSUInteger, CHRequestResponseType) {
    CHRequestResponseTypeJSON , // 默认
    CHRequestResponseTypeXML  ,
    CHRequestResponseTypeData
};

@class CHBaseRequest;

// 请勿直接使用NSURLSessionDataTask,以减少对第三方的依赖
// 所有接口返回的类型都是基类NSURLSessionTask，若要接收返回值
// 且处理，请转换成对应的子类类型
typedef NSURLSessionTask CHURLSessionTask;

typedef void(^CHRequestCompletionBlock)(__kindof CHBaseRequest *request);

@interface CHBaseRequest : NSObject

@property (strong ,nonatomic ) CHNetResponse *response;

@property (strong ,nonatomic ) CHURLSessionTask *session;

@property (copy ,nonatomic ) CHRequestCompletionBlock successfulBlock;

@property (copy ,nonatomic ) CHRequestCompletionBlock failureBlock;

/**
 *  block回调
 */
- (void)startWithSuccessBlock:(CHRequestCompletionBlock)success
                failureBlock:(CHRequestCompletionBlock)failure;

- (void)setSuccessBlock:(CHRequestCompletionBlock)success
           failureBlock:(CHRequestCompletionBlock)failure;

/**
 *  把block置nil来打破循环引用
 */
- (void)clearCompletionBlock;

/// 请求路径的URL
- (NSString *)requestPathUrl;

/// 自定义请求URL 和requestPathUrl Baseurl不可重复使用
- (NSString *)customUrl;

/// 请求的连接超时时间，默认为60秒
- (NSTimeInterval)requestTimeoutInterval;

/// 请求的参数
- (NSDictionary *)requestParameter;


/// Http请求的方法
- (CHRequestMethod)requestMethod;

/// 请求的SerializerType
- (CHRequestSerializerType)requestSerializerType;

/// 请求的ResponseType
- (CHRequestResponseType)requestResponseType;

/// 在HTTP请求头添加的自定义参数
- (NSDictionary *)requestHeaderFieldValueDictionary;

/// 在block回调完成后事件处理
- (void)requestCompletionAfterBlock;
/// 在block回调完成前事件处理
- (void)requestCompletionBeforeBlock;

- (void)stop;

- (void)start;
@end
