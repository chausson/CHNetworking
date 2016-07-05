//
//  CHNetworkConfig.m
//  CHNetworkingDemo
//
//  Created by XiaoSong on 16/3/3.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "CHNetworkConfig.h"
#import "CHNetworkPrivate.h"
@implementation CHNetworkConfig{
    NSMutableArray <NSDictionary *>*_baseArray;
    NSMutableArray <NSDictionary *>*_headerFieldArray;
}
+ (CHNetworkConfig *)sharedInstance{
    static CHNetworkConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[self alloc]init];
        config->_maxConcurrentOperationCount = 3;
        config->_allowPrintLog = NO;
        config->_headerFieldArray = [NSMutableArray array];
        config->_cacheTimeInSeconds = -1;
    });
    return config;
}
- (void)clearHeaderFiled{
    [_headerFieldArray removeAllObjects];
}
- (void)addBaseParameter:(NSDictionary *)parameter{
    NSAssert([parameter isKindOfClass:[NSDictionary class]], @"Error! addBaseParameter Paramerter is not request class");
    [_baseArray addObject:parameter];

}
- (void)addheaderFieldParameter:(NSDictionary *)parameter{
    NSAssert([parameter isKindOfClass:[NSDictionary class]], @"Error! addBaseParameter Paramerter is not request class");
    [_headerFieldArray addObject:parameter];
}
- (NSArray <NSDictionary *>*)baseParameters{
    return [_baseArray copy];
    
}
- (NSArray <NSDictionary *>*)headerFieldParameters{
    return [_headerFieldArray copy];
    
}
- (void)clearRequestCache{
    NSString *pathOfLibrary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathOfLibrary stringByAppendingPathComponent:@"CHCacheRequestData"];
    
    // filter cache base path
    [self clearPath:path];
}
- (void)clearPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        return;
    } else {
        NSError *error = nil;
        [fileManager removeItemAtPath:path error:&error];
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
@end
