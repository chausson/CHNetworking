//
//  CHNetResponse.m
//  CHNetworkingDemo
//
//  Created by XiaoSong on 16/3/3.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "CHNetResponse.h"
#import "CHNetworkPrivate.h"
#import "JSONModel.h"
@implementation CHNetResponse{
    Class _responseClass;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
// 处理解析方法
- (JSONModel *)serializerObject{
    Class jsonClass = _responseClass;
    if (jsonClass != nil) {
        if ([jsonClass isSubclassOfClass:JSONModel.class]) {
            NSError *error ;
            
            JSONModel *model = [[jsonClass alloc]initWithDictionary:self->_responseJSONObject error:&error];
            if(error){
                         CHLog(@"Serializer Error Class is %@",error);   
            }

            return model;
        }else{
            CHLog(@"Serializer Error Class is not JSONModel");
        }
        
    }
    return  nil;
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
- (void)setSerializerClass:(Class )obj{
    _responseClass = obj;
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
