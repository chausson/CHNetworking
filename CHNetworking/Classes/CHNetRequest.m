//
//  CHNetRequest.m
//  CHNetworkingDemo
//
//  Created by XiaoSong on 16/3/3.
//  Copyright © 2016年 CM. All rights reserved.
//
#import "CHNetworkPrivate.h"
#import "CHNetRequest.h"
#import "CHNetworkConfig.h"
@interface CHNetRequest()

@property (strong, nonatomic) id cacheJson;
@property (assign, nonatomic) BOOL dataFromCache;
@end
@implementation CHNetRequest

- (id)cacheJson {
    if (_cacheJson) {
        return _cacheJson;
    } else {
        NSString *path = [self cacheFilePath];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:path isDirectory:nil] == YES) {
            _cacheJson = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        }
        return _cacheJson;
    }
}
- (CHNetResponse *)response{
    if (_cacheJson && ![super response] && self.isIgnoreCache) {
        return [[CHNetResponse alloc]initWithResponse:nil andCallBackData:_cacheJson];

    } else {
        
        return [super response];
    }
}
- (void)checkDirectory:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        [self createBasePath:path];
    } else {
        if (!isDir) {
            NSError *error = nil;
            [fileManager removeItemAtPath:path error:&error];
            [self createBasePath:path];
        }
    }
}

- (void)createBasePath:(NSString *)path {
    __autoreleasing NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES
                                               attributes:nil error:&error];
    if (error) {
        CHLog(@"%s %s %d %@", __PRETTY_FUNCTION__,__FILE__,__LINE__,error);
    } else {
   
    }
}
- (NSString *)cacheBasePath {
    NSString *pathOfLibrary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathOfLibrary stringByAppendingPathComponent:@"CHCacheRequestData"];
    
    // filter cache base path
    [self checkDirectory:path];
    return path;
}
- (NSString *)cacheFileName {
    NSString *requestUrl = [self requestPathUrl];
    NSString *baseUrl = [CHNetworkConfig sharedInstance].baseUrl;
    NSString *requestInfo = [NSString stringWithFormat:@"Method:%ld Host:%@ Url:%@ Argument:%@ AppVersion:%@",
                             (long)[self requestMethod], baseUrl, requestUrl,
                             [self requestParameter], [CHNetworkPrivate clientVersion]];
    NSString *cacheFileName = [CHNetworkPrivate md5FromString:requestInfo];
    return cacheFileName;
}

- (NSString *)cacheFilePath {
    NSString *cacheFileName = [self cacheFileName];
    NSString *path = [self cacheBasePath];
    path = [path stringByAppendingPathComponent:cacheFileName];
    return path;
}

- (NSString *)cacheVersionFilePath {
    NSString *cacheVersionFileName = [NSString stringWithFormat:@"%@.version", [self cacheFileName]];
    NSString *path = [self cacheBasePath];
    path = [path stringByAppendingPathComponent:cacheVersionFileName];
    return path;
}
// 判断是否存在缓存
- (long long)cacheVersionFileContent {
    NSString *path = [self cacheVersionFilePath];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path isDirectory:nil]) {
        NSNumber *version = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        return [version longLongValue];
    } else {
        return 0;
    }
}

- (int)cacheFileDuration:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // get file attribute
    NSError *error = nil;
    NSDictionary *attributes = [fileManager attributesOfItemAtPath:path
                                                             error:&error];
    if (!attributes) {
        CHLog(@"%s %s %d %@", __PRETTY_FUNCTION__,__FILE__,__LINE__,error);
        return -1;
    }
    int seconds = -[[attributes fileModificationDate] timeIntervalSinceNow];
    return seconds;
}
- (void)start {
    if (self.isIgnoreCache) {
        [super start];
        return;
    }
    
    // check cache time
    if ([self cacheTimeInSeconds] < 0) {
        [super start];
        return;
    }
    
    // check cache version
    long long cacheVersionFileContent = [self cacheVersionFileContent];
    if (cacheVersionFileContent != [self cacheVersion]) {
        [super start];
        return;
    }
    
    // check cache existance
    NSString *path = [self cacheFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path isDirectory:nil]) {
        [super start];
        return;
    }
    
    // check cache time
    int seconds = [self cacheFileDuration:path];
    if (seconds < 0 || seconds > [self cacheTimeInSeconds]) {
        [super start];
        return;
    }
    
    // load cache
    _cacheJson = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (_cacheJson == nil) {
        [super start];
        return;
    }
    
    _dataFromCache = YES;

    CHNetRequest *strongSelf = self;
    [strongSelf.delegate requestFinished:strongSelf];
    if ([strongSelf respondsToSelector:@selector(requestCompletionBeforeBlock)]) {
        [strongSelf requestCompletionBeforeBlock];
    }
    if (strongSelf.successfulBlock) {
        strongSelf.successfulBlock(strongSelf);
    }
    if ([strongSelf respondsToSelector:@selector(requestCompletionAfterBlock)]) {
        [strongSelf requestCompletionAfterBlock];
    }
    [strongSelf clearCompletionBlock];
}

- (void)startWithoutCache {
    [super start];
}
/// 是否当前的数据从缓存获得
- (BOOL)isDataFromCache{
    return _dataFromCache;
}

- (BOOL)isCacheNeedUpdate{
    // check cache version
    long long cacheVersionFileContent = [self cacheVersionFileContent];
    if (cacheVersionFileContent != [self cacheVersion]) {
        return YES;
    } else {
        return NO;
    }
}


- (NSInteger)cacheTimeInSeconds{
    return [CHNetworkConfig sharedInstance].cacheTimeInSeconds;
}

- (long long)cacheVersion{
    return 0;
}
- (void)requestCompletionBeforeBlock{
    NSObject *analysisModel = [self analysisModel];
    if (analysisModel ) {
        [CHNetworkPrivate analysisJSONWithDict:self.response.responseJSONObject toModel:analysisModel];
    }
    [super requestCompletionBeforeBlock];
}
- (void)requestCompletionAfterBlock{

    [self saveJsonResponseToCacheFile:self.response.responseJSONObject];

    [super requestCompletionAfterBlock];
}
// 存储cache json
- (void)saveJsonResponseToCacheFile:(id)jsonResponse {
    if ([self cacheTimeInSeconds] > 0 ) {
        NSDictionary *json = jsonResponse;
        if (json != nil) {
            [NSKeyedArchiver archiveRootObject:json toFile:[self cacheFilePath]];
            [NSKeyedArchiver archiveRootObject:@([self cacheVersion]) toFile:[self cacheVersionFilePath]];
        }
    }
}
- (NSObject *)analysisModel{
    
    return nil;
}
@end
