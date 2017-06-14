//
//  CHNetworkAgent.m
//  CHNetworkingDemo
//
//  Created by XiaoSong on 16/3/3.
//  Copyright © 2016年 CM. All rights reserved.
//
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "CHNetworkAgent.h"
#import "CHNetworkConfig.h"
#import "CHBaseRequest.h"
#import "CHNetResponse.h"
#import "CHNetworkPrivate.h"
@implementation CHNetworkAgent{
    CHNetworkConfig *_config;
    NSMutableDictionary *_requestsRecord;
}
+ (CHNetworkAgent *)sharedInstance{
    static CHNetworkAgent  *agent = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        agent = [[self alloc]init];
    });
    return agent;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _config = [CHNetworkConfig sharedInstance];
        _requestsRecord = [NSMutableDictionary dictionary];
    }
    return self;
}
#pragma mark - Private
- (AFHTTPSessionManager *)createManagerWithRequeset:(CHBaseRequest *)request{
    // 开启转圈圈
    AFHTTPSessionManager *manager = nil;
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;

    if (_config.baseUrl.length > 0 && request.customUrl.length == 0) {
        manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:_config.baseUrl]];
    }else{
        manager = [AFHTTPSessionManager manager];
    }
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;


    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    manager.operationQueue.maxConcurrentOperationCount = [_config maxConcurrentOperationCount] ;
    manager.requestSerializer.timeoutInterval = [request requestTimeoutInterval];
    

    //默认是json
    switch (request.requestSerializerType) {
        case CHRequestSerializerTypeJSON: {
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            break;
        }
        case CHRequestSerializerPlainText: {
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        }
        default: {
            break;
        }
    }
    switch (request.requestResponseType) {
        case CHRequestResponseTypeJSON: {
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        }
        case CHRequestResponseTypeXML: {
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        }
        case CHRequestResponseTypeData: {
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        }
        default: {
            break;
        }
    }
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    
    for (NSString *key in request.requestHeaderFieldValueDictionary.allKeys) {
        if (request.requestHeaderFieldValueDictionary[key] != nil) {
            [manager.requestSerializer setValue:request.requestHeaderFieldValueDictionary[key] forHTTPHeaderField:key];
        }
    }
    if (_config.headerFieldParameters && ![request isFilterheaderFieldParameter]) {
        [_config.headerFieldParameters enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
            [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                NSString *value = obj;
                if (value.length > 0) {
                    [manager.requestSerializer setValue:value forHTTPHeaderField:key];
                }
                
            }];
        }];
        
    }
    
    return manager;
}
- (NSURLRequest *)assemblyWithRequest:(CHBaseRequest *)request
                                  url:(NSString *)url
                           parameters:(NSDictionary *)parameter{
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSString *paramStr = [CHNetworkPrivate dictionaryToJSONString:parameter];
    NSString *method ;
    if (![request specificDownloadPath]) {
        [req setHTTPMethod:@"DELETE"];

    }
    switch (request.requestMethod) {
        case CHRequestMethodGet:
            method = @"GET";
            break;
        case CHRequestMethodPut:
            method = @"PUT";
            break;
        case CHRequestMethodPost:
            method = @"POST";
            break;
        case CHRequestMethodPatch:
            method = @"PATH";
            break;
        case CHRequestMethodDelete:
            method = @"DELETE";
            break;

        default:
            break;
    }
    switch (request.requestSerializerType) {
        case CHRequestSerializerTypeJSON:
            [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            break;
        case CHRequestSerializerPlainText   :
            [req setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
            break;
        default:
            break;
    }
    for (NSString *key in request.requestHeaderFieldValueDictionary.allKeys) {
        if (request.requestHeaderFieldValueDictionary[key] != nil) {
            [req setValue:request.requestHeaderFieldValueDictionary[key] forHTTPHeaderField:key];
        }
    }
    if (_config.headerFieldParameters && ![request isFilterheaderFieldParameter]) {
        [_config.headerFieldParameters enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
            [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                NSString *value = obj;
                if (value.length > 0) {
                    [req setValue:value forHTTPHeaderField:key];
                }
                
            }];
        }];
        
    }
    NSAssert(method != nil, @"CHRequestMethod Can't Be CHRequestMethodPostData");
    [req setHTTPBody:[paramStr dataUsingEncoding:NSUTF8StringEncoding]];

    return req;
}
- (void)addRequest:(CHBaseRequest *)request{

    AFHTTPSessionManager *manager = [self createManagerWithRequeset:request];
    
    NSString *url = [self createURLWithRequest:request];
//添加公共参数
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]initWithDictionary:request.requestParameter];

    if (_config.baseParameters && ![request isFilterBaseParameter]) {
        [_config.baseParameters enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [parameter addEntriesFromDictionary:obj];
        }];
    }

    if ([request specificDownloadPath]) {
        
        NSURLRequest *res =  [self assemblyWithRequest:request url:url parameters:parameter];
        
        AFHTTPSessionManager *manger = [self createManagerWithRequeset:request];

        request.session = [manger downloadTaskWithRequest:res progress:^(NSProgress * _Nonnull downloadProgress) {
            if (request.progressBlock) {
                request.progressBlock(downloadProgress);
            }
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            return [request specificDownloadPath];
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            if (error) {
                request.response = [[CHNetResponse alloc]initWithResponse:response andCallBackData:error];
            }else{
                request.response = [[CHNetResponse alloc]initWithResponse:response andCallBackData:nil];
            }
            [request.response setValue:filePath forKey:@"filePath"];
            
            [self handleRequestResult:request.session];
        }];
        [request.session resume];
    }else if ([request isHTTPBodyParametersRequest]) {
        //   后台参数放入body中接收 方法
        NSURLRequest *res =  [self assemblyWithRequest:request url:url parameters:parameter];

        request.session = (NSURLSessionTask *)[manager dataTaskWithRequest:res completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (error) {
                request.response = [[CHNetResponse alloc]initWithResponse:response andCallBackData:error];
            }else{
                request.response = [[CHNetResponse alloc]initWithResponse:response andCallBackData:responseObject];
            }

            [self handleRequestResult:request.session];
            }];
        [request.session resume];
        
    } else if (request.requestMethod == CHRequestMethodGet) {
       request.session = [manager GET:url parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
           if (request.progressBlock) {
               request.progressBlock(downloadProgress);
           }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            request.response = [[CHNetResponse alloc]initWithSession:task andCallBackData:responseObject];
            [self handleRequestResult:task];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            request.response = [[CHNetResponse alloc]initWithSession:task andCallBackData:error];
            [self handleRequestResult:task];
        }];
    } else if (request.requestMethod == CHRequestMethodPost) {
        request.session = [manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
            if (request.progressBlock) {
                request.progressBlock(downloadProgress);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            request.response = [[CHNetResponse alloc]initWithSession:task andCallBackData:responseObject];
            [self handleRequestResult:task];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            request.response = [[CHNetResponse alloc]initWithSession:task andCallBackData:error];
            [self handleRequestResult:task];
        }];
    } else if (request.requestMethod == CHRequestMethodPut) {
        request.session = [manager PUT:url parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            request.response = [[CHNetResponse alloc]initWithSession:task andCallBackData:responseObject];
            [self handleRequestResult:task];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            request.response = [[CHNetResponse alloc]initWithSession:task andCallBackData:error];
            [self handleRequestResult:task];
        }];
    }else if (request.requestMethod == CHRequestMethodPatch) {
        request.session = [manager PATCH:url parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            request.response = [[CHNetResponse alloc]initWithSession:task andCallBackData:responseObject];
            [self handleRequestResult:task];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            request.response = [[CHNetResponse alloc]initWithSession:task andCallBackData:error];
            [self handleRequestResult:task];
        }];
    }else if (request.requestMethod == CHRequestMethodDelete) {
        request.session = [manager DELETE:url parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            request.response = [[CHNetResponse alloc]initWithSession:task andCallBackData:responseObject];
            [self handleRequestResult:task];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            request.response = [[CHNetResponse alloc]initWithSession:task andCallBackData:error];
            [self handleRequestResult:task];
        }];
    }else if (request.requestMethod == CHRequestMethodPostData) {
        if (request.requestDataInfo) {
            NSData *data = [request.requestDataInfo objectForKey:@"data"];
            NSString *name = [request.requestDataInfo objectForKey:@"name"];
            NSString *filename = [request.requestDataInfo objectForKey:@"filename"];
            NSString *mimeType = [request.requestDataInfo objectForKey:@"mimeType"];
            if (data.length == 0 || name.length == 0 || filename.length == 0 || mimeType.length == 0) {
                if ([CHNetworkConfig sharedInstance].allowPrintLog) {
                    CHLog(@"上传文件的格式拼接错误");
                }
                return;
            }
            request.session = [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                [formData appendPartWithFileData:data name:name fileName:filename mimeType:mimeType];
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                if (request.progressBlock) {
                    request.progressBlock(uploadProgress);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                request.response = [[CHNetResponse alloc]initWithSession:task andCallBackData:responseObject];
                [self handleRequestResult:task];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                request.response = [[CHNetResponse alloc]initWithSession:task andCallBackData:error];
                [self handleRequestResult:task];
            }];
        }else{
            if ([CHNetworkConfig sharedInstance].allowPrintLog) {
                CHLog(@"上传文件的数据不存在");
            }
  
            return;

        }

    }
    [self addOperation:request];
    
    if ([CHNetworkConfig sharedInstance].allowPrintLog) {
        CHLog(@"Headers =%@ \n", manager.requestSerializer.HTTPRequestHeaders);
    }
    
    
}
- (void)cancelRequest:(CHBaseRequest *)request{
    if (request.session) {
        [request.session cancel];
        [self removeOperation:request.session];
        [request clearCompletionBlock];
    }

}

- (NSString *)createURLWithRequest:(CHBaseRequest *)request{
    NSString *url = request.customUrl;
    if (url.length == 0) {
        NSAssert(_config.baseUrl.length > 0 , @"basurl is nil");
        NSAssert(request.requestPathUrl.length > 0 , @"pathUrl is nil");
        url = [NSString stringWithFormat:@"%@%@",_config.baseUrl,request.requestPathUrl];
    }
    if (![url hasPrefix:@"http"]) {
        url = [NSString stringWithFormat:@"http://%@",url];
    }
    return url;
}
- (void)handleRequestResult:(CHURLSessionTask *)session{
    NSString *key = [self requestHashKey:session];
    CHBaseRequest *request = _requestsRecord[key];

    if (request.delegate  != nil && [request.delegate respondsToSelector:@selector(requestBeforeFinished:)]) {
        [request.delegate requestBeforeFinished:request];
    }
    if (request) {
        if ([request respondsToSelector:@selector(requestCompletionBeforeBlock)]) {
            [request requestCompletionBeforeBlock];
        }
        if (request.response.error) {
            if (request.delegate  != nil && [request.delegate respondsToSelector:@selector(requestFailed:)]) {
                [request.delegate requestFailed:request];
            }
            if (request.failureBlock) {
                request.failureBlock(request);
            }
        }else{
            if (request.delegate  != nil && [request.delegate respondsToSelector:@selector(requestFinished:)]) {
                [request.delegate requestFinished:request];
            }
            if (request.successfulBlock) {
                request.successfulBlock(request);
            }

        }
        if ([request respondsToSelector:@selector(requestCompletionAfterBlock)]) {
            [request requestCompletionAfterBlock];
        }

    }
    [self removeOperation:request.session];
    [request clearCompletionBlock];
 
    if ([CHNetworkConfig sharedInstance].allowPrintLog) {
        CHLog(@"Finished Request Class: %@ StatusCode= %d URL=%@ Parameters= %@ response=%@\n@", NSStringFromClass([request class]),(int)request.response.statusCode,[request.response.responseURL description],[request requestParameter],request.response.responseJSONObject);
    }

}
- (void)addOperation:(CHBaseRequest *)request {
    if (request.session != nil) {
        NSString *key = [self requestHashKey:request.session];
        @synchronized(self) {
            _requestsRecord[key] = request;
        }
    }
}
- (NSString *)requestHashKey:(CHURLSessionTask *)operation {
    NSString *key = [NSString stringWithFormat:@"%lu", (unsigned long)[operation hash]];
    return key;
}
- (void)removeOperation:(CHURLSessionTask *)operation {
    NSString *key = [self requestHashKey:operation];
    @synchronized(self) {
        [_requestsRecord removeObjectForKey:key];
        if ([CHNetworkConfig sharedInstance].allowPrintLog) {
            CHLog(@"Request queue size = %lu", (unsigned long)[_requestsRecord count]);
        }
    }
  

}
@end
