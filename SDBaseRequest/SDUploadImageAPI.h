//
//  SDUploadImageAPI.h
//  FrameWorkPractice
//
//  Created by Chausson on 16/5/26.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHNetworking.h"
#import "SDBaseResponse.h"

@interface SDUploadImageAPI : CHNetRequest
+ (instancetype)new __unavailable;
- (instancetype)init  __unavailable;
- (instancetype)initWithImage:(UIImage *)image
                    imageName:(NSString *)imageName
                     fileName:(NSString *)fileName;

@property (nonatomic ,readonly ) SDBaseResponse *baseResponse;

@property (nonatomic ,readonly) NSString *imageName;

@property (nonatomic ,readonly) NSString *fileName;

@end
