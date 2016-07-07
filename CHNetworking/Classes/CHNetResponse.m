//
//  CHNetResponse.m
//  CHNetworkingDemo
//
//  Created by XiaoSong on 16/3/3.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "CHNetResponse.h"
#import "CHNetworkPrivate.h"
#import "CHNetworkConfig.h"
@implementation CHNetResponse
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithSession:(NSURLSessionDataTask *)session andCallBackData:(id)data{

    CHNetResponse *response = [self assemblyResponseWithNSURLResponse:(NSHTTPURLResponse *)session.response data:data];
    if (response) {
            response->_taskIdentifier = session.taskIdentifier;
            response->_responseURL = session.response.URL;
    }
    
    return response;

}
- (instancetype)initWithResponse:(NSURLResponse *)res andCallBackData:(id)data{
    
    CHNetResponse *response = [self assemblyResponseWithNSURLResponse:(NSHTTPURLResponse *)res data:data];
    if (response) {
        
    }
    return response;
}
- (CHNetResponse *)assemblyResponseWithNSURLResponse:(NSHTTPURLResponse *)res data:(id)data{
    CHNetResponse *response = [[CHNetResponse alloc]init];
    NSHTTPURLResponse *httpResponse = res;
    if(httpResponse){
        response->_statusCode = httpResponse.statusCode;
        response->_responseURL = res.URL;
        response->_allHeaderFields = httpResponse.allHeaderFields;
    }
    if ([data isKindOfClass:[NSError class]]) {
        response->_error = data;
    }else if( httpResponse.statusCode != 200){
        response->_error = [NSError errorWithDomain:@"StatusCodeError" code:httpResponse.statusCode userInfo:@{@"response":[httpResponse description]}];
    }else{
        if (data &&  data != (id)kCFNull) {
            if ([data isKindOfClass:[NSDictionary class]]) response-> _responseJSONObject = data;
            
            if ([data isKindOfClass:[NSData class]])   response-> _responseData = data;
            
        }
    }
    return response;
}

@end
