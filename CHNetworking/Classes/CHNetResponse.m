//
//  CHNetResponse.m
//  CHNetworkingDemo
//
//  Created by XiaoSong on 16/3/3.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "CHNetResponse.h"
#import "CHNetworkPrivate.h"
#import "CHModelObject.h"
@implementation CHNetResponse
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (NSObject *)responseObject{
    NSObject *obj;
    if (_serializerClass && _responseJSONObject != (id)kCFNull) {
        Class jsonClass = _serializerClass;
        if ( [CHNetworkPrivate checkJSONModelWithClass:jsonClass]) {
            obj = [(id<CHModelObject>)jsonClass initWithDictionary:_responseJSONObject error:nil];
        }else{
            obj = [(id<CHModelObject>)jsonClass CH_modelWithDictionary:_responseJSONObject];
        }
    }
    NSAssert(obj == nil,@"CHNetResponse.m line 36 responseObject is nil");
    return obj;
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
    response->_statusCode = httpResponse.statusCode;
    response->_responseURL = res.URL;
    response->_allHeaderFields = httpResponse.allHeaderFields;
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
- (void)setSerializerClass:(Class )obj{
    _serializerClass = obj;
}
- (void)setResponseObj:(NSObject *)responseObject{
    if ([responseObject respondsToSelector:@selector(initWithDictionary:error:)]) {
        responseObject = [(id<CHModelObject>) responseObject initWithDictionary:_responseJSONObject error:nil];
    }else{
        [(id<CHModelObject>)responseObject.class CH_modelWithDictionary:_responseJSONObject toModel:responseObject];
    }

}
//// 将JSON串转化为字典或者数组
//- (id)toArrayOrNSDictionary:(NSData *)jsonData{
//    NSError *error = nil;
//    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                    options:NSJSONReadingAllowFragments
//                                                      error:&error];
//    
//    if (jsonObject != nil && error == nil){
//        return jsonObject;
//    }else{
//        // 解析错误
//        return nil;
//    }
//    
//}
@end
