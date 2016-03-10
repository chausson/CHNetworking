//
//  CHNetResponse.m
//  CHNetworkingDemo
//
//  Created by XiaoSong on 16/3/3.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "CHNetResponse.h"
#import "CHNetworkPrivate.h"

@implementation CHNetResponse
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithSession:(NSURLSessionDataTask *)session andCallBackData:(id)data{
    CHNetResponse *response = [[CHNetResponse alloc]init];
    response->_taskIdentifier = session.taskIdentifier;
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)session.response;
    response->_statusCode = httpResponse.statusCode;
    response->_responseURL = session.response.URL;
    response->_allHeaderFields = httpResponse.allHeaderFields;
    if ([data isKindOfClass:[NSError class]]) {
        response->_error = data;
    }else if( httpResponse.statusCode != 200){
        response->_error = [NSError errorWithDomain:@"StatusCodeError" code:httpResponse.statusCode userInfo:@{@"response":[httpResponse description]}];
    }else{
        response->_responseData = data;
        response-> _responseJSONObject = data;
    }

    return response;
}
// 将JSON串转化为字典或者数组
- (id)toArrayOrNSDictionary:(NSData *)jsonData{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
    
}
@end
