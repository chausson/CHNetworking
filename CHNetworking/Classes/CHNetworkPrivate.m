//
//  CHNetworkPrivate.m
//  CHNetworkingDemo
//
//  Created by XiaoSong on 16/3/3.
//  Copyright © 2016年 CM. All rights reserved.
//
#import "CHModelObject.h"
#import "CHNetworkPrivate.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>
void CHLog(NSString *format, ...) {
#ifdef DEBUG
    va_list argptr;
    va_start(argptr, format);
    NSLogv(format, argptr);
    va_end(argptr);
#endif
}
@implementation CHNetworkPrivate
+ (NSString *)dictionaryToJSONString:(NSDictionary *)parameter{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameter options:NSJSONWritingPrettyPrinted error:&error];
    if (!jsonData) {
        return @"";
    }
    
    NSString* jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}
+ (NSString *)clientVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
+ (BOOL)checkJSONModel:(id )obj{

    if (obj == [NSNull null]) {
        CHLog(@"checkJSONModel obj is nil");
        return NO;
    }
    Class jsonModel = NSClassFromString(@"JSONModel");
    if (object_isClass(obj) ) {
        return [[[obj alloc]init] isKindOfClass:jsonModel] && [obj instancesRespondToSelector:@selector(initWithDictionary:error:)];
    }else{
        return [obj respondsToSelector:@selector(initWithDictionary:error:)] && [obj isKindOfClass:jsonModel];
    }
}
+ (NSString *)md5FromString:(NSString *)string {
    if(string == nil || [string length] == 0)
        return nil;
    
    const char *value = [string UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}
+ (BOOL)checkJson:(id)json withValidator:(id)validatorJson {
    if ([json isKindOfClass:[NSDictionary class]] &&
        [validatorJson isKindOfClass:[NSDictionary class]]) {
        NSDictionary * dict = json;
        NSDictionary * validator = validatorJson;
        BOOL result = YES;
        NSEnumerator * enumerator = [validator keyEnumerator];
        NSString * key;
        while ((key = [enumerator nextObject]) != nil) {
            id value = dict[key];
            id format = validator[key];
            if ([value isKindOfClass:[NSDictionary class]]
                || [value isKindOfClass:[NSArray class]]) {
                result = [self checkJson:value withValidator:format];
                if (!result) {
                    break;
                }
            } else {
                if ([value isKindOfClass:format] == NO &&
                    [value isKindOfClass:[NSNull class]] == NO) {
                    result = NO;
                    break;
                }
            }
        }
        return result;
    } else if ([json isKindOfClass:[NSArray class]] &&
               [validatorJson isKindOfClass:[NSArray class]]) {
        NSArray * validatorArray = (NSArray *)validatorJson;
        if (validatorArray.count > 0) {
            NSArray * array = json;
            NSDictionary * validator = validatorJson[0];
            for (id item in array) {
                BOOL result = [self checkJson:item withValidator:validator];
                if (!result) {
                    return NO;
                }
            }
        }
        return YES;
    } else if ([json isKindOfClass:validatorJson]) {
        return YES;
    } else {
        return NO;
    }
}
+ (void)cancelBackupFileAtICloud:(NSString *)path{
    NSError *error = nil;
    NSURL *url = [NSURL fileURLWithPath:path];

    [url setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (error) {
        CHLog(@"%s %s %d %@", __PRETTY_FUNCTION__,__FILE__,__LINE__,error);
    }
}
+ (void )analysisJSONWithDict:(NSDictionary*)dic toModel:(NSObject *)model{
    if ( [CHNetworkPrivate checkJSONModel:model.class]) {
        [CHNetworkPrivate analysisJSONWithDict:dic model:&model obj:model];
 
    }else{
        [(id<CHModelObject>)model.class CH_modelWithDictionary:dic toModel:model];

    }

    
}
+ (void)analysisJSONWithDict:(NSDictionary*)dic model:(NSObject **)model obj:(NSObject *)obj{
    NSError *error;
    if ([obj respondsToSelector:@selector(initWithDictionary:error:)] && dic) {
        *model = [(id<CHModelObject>)obj initWithDictionary:dic error:&error];
    }else{
        *model = nil;
    }
    if (error) CHLog(@"%s %@",__PRETTY_FUNCTION__,[error description]);
}
@end
