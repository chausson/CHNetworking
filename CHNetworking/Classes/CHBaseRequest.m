//
//  CHBaseRequest.m
//  CHNetworkingDemo
//
//  Created by XiaoSong on 16/3/3.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "CHBaseRequest.h"
#import "CHNetworkPrivate.h"
#import "CHNetworkAgent.h"
@implementation CHBaseRequest
- (NSString *)requestPathUrl{
    return @"";
}
- (NSDictionary *)requestDataInfo{
    return nil;
}
- (NSURL *)specificDownloadPath{
    return nil;
}
- (NSString *)customUrl{
    return @"";
}

- (NSTimeInterval)requestTimeoutInterval{
    return 60;
}

/// 请求的参数
- (NSDictionary *)requestParameter{
    return nil;
}
- (BOOL )isFilterBaseParameter{
    return NO;
}
- (BOOL )isFilterheaderFieldParameter{
    return NO;
}
- (BOOL )isHTTPBodyParametersRequest{
    return NO;
}
/// 需要返回的模型对象
- (Class)responseModelClass{
    return nil;
}
/// 返回需要的模型对象
- (NSObject *)responseObject{
    return nil;
}
/// Http请求的方法
- (CHRequestMethod)requestMethod{
    return CHRequestMethodGet;
}

/// 请求的SerializerType
- (CHRequestSerializerType)requestSerializerType{
    return CHRequestSerializerTypeJSON;
}

/// 请求的ResponseType
- (CHRequestResponseType)requestResponseType{
    return CHRequestResponseTypeJSON;
}

/// 在HTTP请求头添加的自定义参数
- (NSDictionary *)requestHeaderFieldValueDictionary{
    return nil;
}
- (void)startWithSuccessBlock:(CHRequestCompletionBlock)success
                 failureBlock:(CHRequestCompletionBlock)failure{
    [self setSuccessBlock:success failureBlock:failure];
    [self start];
}

- (void)setSuccessBlock:(CHRequestCompletionBlock)success
           failureBlock:(CHRequestCompletionBlock)failure{
    _successfulBlock = success;
    _failureBlock = failure;
}

- (void)clearCompletionBlock{
    self.successfulBlock = nil;
    self.failureBlock = nil;
}
- (void)start{
    [self requestWillStart];
    [[CHNetworkAgent sharedInstance]addRequest:self];
}
- (void)stop{
    [self requestWillStop];
    self.delegate = nil;
    [[CHNetworkAgent sharedInstance]cancelRequest:self];
    [self requestDidStop];
}
- (void)requestWillStart{
    
}
- (void)requestWillStop{
    
}
- (void)requestDidStop{
    
}
- (void)requestCompletionAfterBlock{
    
}

- (void)requestCompletionBeforeBlock{
    
}
@end
