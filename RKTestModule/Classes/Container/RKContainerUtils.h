//
//  RKContainerUtils.h
//  RKMicAppContainerModule
//
//  Created by 贾晓滨 on 2021/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RKNetworkType) {
    TWO_G,
    THREE_G,
    FOUR_G,
    WIFI,
    UNKNOWN
};

@interface RKContainerUtils : NSObject
+ (BOOL)validateString:(NSString *)string;
+ (BOOL)validateArray:(NSArray *)array;
+ (BOOL)validateDictionary:(NSDictionary *)dictionary;

+ (NSString *)arrayToJson:(NSArray *)array;
+ (NSString *)dictionaryToJson:(NSDictionary *)dictionary;

+ (NSString *)escapeURIComponent:(NSString *)component;

+ (NSDictionary *)specialParams;

+ (NSTimeInterval)currentTime;
+ (unsigned long long)diffTime:(struct timeval *)tvStart endTime:(struct timeval *)tvEnd;
+ (NSString *)stringForTimeVal:(struct timeval *)tv;
+ (NSString *)stringForCurrentTime;
+ (nullable NSString *)jdmk_jsonStringFromObject:(id)object;
+ (nullable NSData *)jdmk_jsonDataFromObject:(id)object;
+ (nullable id)jdmk_jsonObjectFromString:(NSString *)str;
+ (nullable id)jdmk_jsonObjectFromData:(NSData *)data;

// 加密
+ (NSString *)hmacSHA256StringWithData:(NSData*)data
                                   key:(NSString *)key;
// gzip压缩
+ (NSData *)gzipDeflate:(NSData*)data;
// Crypto
+ (NSString *)string_to_md5:(NSString *)input;
+ (NSString *)string_to_gzip_base64_string:(NSString *)input;
+ (NSString *)epoch_time_string_6_digits;
+ (NSString *)token:(NSString *)timestamp;
+ (NSString *)gzip_base64_compression:(NSString *)input;

// 网络状态
+ (NSString *)network_type_to_string;

// Log
+ (void)debug_assert_objc:(NSString *)assertion;
+ (void)debug_nslog:(NSString *)log;
+ (void)catch_exception:(NSString *)info;

@end

NS_ASSUME_NONNULL_END
