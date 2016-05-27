//
//  SDUploadImageAPI.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/5/26.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "SDUploadImageAPI.h"

@implementation SDUploadImageAPI{
    NSData *_imageData;

}
- (instancetype)initWithImage:(UIImage *)image
                    imageName:(NSString *)imageName
                     fileName:(NSString *)fileName{
    self = [super init];
    if (self) {
        NSParameterAssert(image);
        _imageName = imageName;
        _fileName = fileName;
        if (UIImagePNGRepresentation(image) == nil) {
            
            _imageData = UIImageJPEGRepresentation(image, 1);
            
        } else {
            
            _imageData = UIImagePNGRepresentation(image);
        }
    }
    return self;
}

- (NSDictionary *)requestDataInfo{
    return @{@"data":_imageData,
             @"name":_imageName,
             @"filename":_fileName,
             @"mimeType":@"image/jpeg"};
}
- (CHRequestMethod)requestMethod{
    return CHRequestMethodPostData;
}
- (NSString *)requestPathUrl{
    return @"/image";
}
- (void)requestCompletionBeforeBlock{
    _baseResponse = [[SDBaseResponse alloc]initWithJSON:self.response.responseJSONObject];
}
@end
