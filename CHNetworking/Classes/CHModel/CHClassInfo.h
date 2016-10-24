//
//  CHClassInfo.h
//  为避免和pod导入的YYModel重名冲突，2016年修改YYModel前缀使用，感谢开源！
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Type encoding's type.
 */
typedef NS_OPTIONS(NSUInteger, CHEncodingType) {
    CHEncodingTypeMask       = 0xFF, ///< mask of type value
    CHEncodingTypeUnknown    = 0, ///< unknown
    CHEncodingTypeVoid       = 1, ///< void
    CHEncodingTypeBool       = 2, ///< bool
    CHEncodingTypeInt8       = 3, ///< char / BOOL
    CHEncodingTypeUInt8      = 4, ///< unsigned char
    CHEncodingTypeInt16      = 5, ///< short
    CHEncodingTypeUInt16     = 6, ///< unsigned short
    CHEncodingTypeInt32      = 7, ///< int
    CHEncodingTypeUInt32     = 8, ///< unsigned int
    CHEncodingTypeInt64      = 9, ///< long long
    CHEncodingTypeUInt64     = 10, ///< unsigned long long
    CHEncodingTypeFloat      = 11, ///< float
    CHEncodingTypeDouble     = 12, ///< double
    CHEncodingTypeLongDouble = 13, ///< long double
    CHEncodingTypeObject     = 14, ///< id
    CHEncodingTypeClass      = 15, ///< Class
    CHEncodingTypeSEL        = 16, ///< SEL
    CHEncodingTypeBlock      = 17, ///< block
    CHEncodingTypePointer    = 18, ///< void*
    CHEncodingTypeStruct     = 19, ///< struct
    CHEncodingTypeUnion      = 20, ///< union
    CHEncodingTypeCString    = 21, ///< char*
    CHEncodingTypeCArray     = 22, ///< char[10] (for example)
    
    CHEncodingTypeQualifierMask   = 0xFF00,   ///< mask of qualifier
    CHEncodingTypeQualifierConst  = 1 << 8,  ///< const
    CHEncodingTypeQualifierIn     = 1 << 9,  ///< in
    CHEncodingTypeQualifierInout  = 1 << 10, ///< inout
    CHEncodingTypeQualifierOut    = 1 << 11, ///< out
    CHEncodingTypeQualifierBycopy = 1 << 12, ///< bycopy
    CHEncodingTypeQualifierByref  = 1 << 13, ///< byref
    CHEncodingTypeQualifierOneway = 1 << 14, ///< oneway
    
    CHEncodingTypePropertyMask         = 0xFF0000, ///< mask of property
    CHEncodingTypePropertyReadonly     = 1 << 16, ///< readonly
    CHEncodingTypePropertyCopy         = 1 << 17, ///< copy
    CHEncodingTypePropertyRetain       = 1 << 18, ///< retain
    CHEncodingTypePropertyNonatomic    = 1 << 19, ///< nonatomic
    CHEncodingTypePropertyWeak         = 1 << 20, ///< weak
    CHEncodingTypePropertyCustomGetter = 1 << 21, ///< getter=
    CHEncodingTypePropertyCustomSetter = 1 << 22, ///< setter=
    CHEncodingTypePropertyDynamic      = 1 << 23, ///< @dynamic
};

/**
 Get the type from a Type-Encoding string.
 
 @discussion See also:
 https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
 https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html
 
 @param typeEncoding  A Type-Encoding string.
 @return The encoding type.
 */
CHEncodingType CHEncodingGetType(const char *typeEncoding);


/**
 Instance variable information.
 */
@interface CHClassIvarInfo : NSObject
@property (nonatomic, assign, readonly) Ivar ivar;              ///< ivar opaque struct
@property (nonatomic, strong, readonly) NSString *name;         ///< Ivar's name
@property (nonatomic, assign, readonly) ptrdiff_t offset;       ///< Ivar's offset
@property (nonatomic, strong, readonly) NSString *typeEncoding; ///< Ivar's type encoding
@property (nonatomic, assign, readonly) CHEncodingType type;    ///< Ivar's type

/**
 Creates and returns an ivar info object.
 
 @param ivar ivar opaque struct
 @return A new object, or nil if an error occurs.
 */
- (instancetype)initWithIvar:(Ivar)ivar;
@end


/**
 Method information.
 */
@interface CHClassMethodInfo : NSObject
@property (nonatomic, assign, readonly) Method method;                  ///< method opaque struct
@property (nonatomic, strong, readonly) NSString *name;                 ///< method name
@property (nonatomic, assign, readonly) SEL sel;                        ///< method's selector
@property (nonatomic, assign, readonly) IMP imp;                        ///< method's implementation
@property (nonatomic, strong, readonly) NSString *typeEncoding;         ///< method's parameter and return types
@property (nonatomic, strong, readonly) NSString *returnTypeEncoding;   ///< return value's type
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *argumentTypeEncodings; ///< array of arguments' type

/**
 Creates and returns a method info object.
 
 @param method method opaque struct
 @return A new object, or nil if an error occurs.
 */
- (instancetype)initWithMethod:(Method)method;
@end


/**
 Property information.
 */
@interface CHClassPropertyInfo : NSObject
@property (nonatomic, assign, readonly) objc_property_t property; ///< property's opaque struct
@property (nonatomic, strong, readonly) NSString *name;           ///< property's name
@property (nonatomic, assign, readonly) CHEncodingType type;      ///< property's type
@property (nonatomic, strong, readonly) NSString *typeEncoding;   ///< property's encoding value
@property (nonatomic, strong, readonly) NSString *ivarName;       ///< property's ivar name
@property (nullable, nonatomic, assign, readonly) Class cls;      ///< may be nil
@property (nonatomic, assign, readonly) SEL getter;               ///< getter (nonnull)
@property (nonatomic, assign, readonly) SEL setter;               ///< setter (nonnull)

/**
 Creates and returns a property info object.
 
 @param property property opaque struct
 @return A new object, or nil if an error occurs.
 */
- (instancetype)initWithProperty:(objc_property_t)property;
@end


/**
 Class information for a class.
 */
@interface CHClassInfo : NSObject
@property (nonatomic, assign, readonly) Class cls; ///< class object
@property (nullable, nonatomic, assign, readonly) Class superCls; ///< super class object
@property (nullable, nonatomic, assign, readonly) Class metaCls;  ///< class's meta class object
@property (nonatomic, readonly) BOOL isMeta; ///< whether this class is meta class
@property (nonatomic, strong, readonly) NSString *name; ///< class name
@property (nullable, nonatomic, strong, readonly) CHClassInfo *superClassInfo; ///< super class's class info
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, CHClassIvarInfo *> *ivarInfos; ///< ivars
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, CHClassMethodInfo *> *methodInfos; ///< methods
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, CHClassPropertyInfo *> *propertyInfos; ///< properties

/**
 If the class is changed (for example: you add a method to this class with
 'class_addMethod()'), you should call this method to refresh the class info cache.
 
 After called this method, `needUpdate` will returns `YES`, and you should call 
 'classInfoWithClass' or 'classInfoWithClassName' to get the updated class info.
 */
- (void)setNeedUpdate;

/**
 If this method returns `YES`, you should stop using this instance and call
 `classInfoWithClass` or `classInfoWithClassName` to get the updated class info.
 
 @return Whether this class info need update.
 */
- (BOOL)needUpdate;

/**
 Get the class info of a specified Class.
 
 @discussion This method will cache the class info and super-class info
 at the first access to the Class. This method is thread-safe.
 
 @param cls A class.
 @return A class info, or nil if an error occurs.
 */
+ (nullable instancetype)classInfoWithClass:(Class)cls;

/**
 Get the class info of a specified Class.
 
 @discussion This method will cache the class info and super-class info
 at the first access to the Class. This method is thread-safe.
 
 @param className A class name.
 @return A class info, or nil if an error occurs.
 */
+ (nullable instancetype)classInfoWithClassName:(NSString *)className;

@end

NS_ASSUME_NONNULL_END
