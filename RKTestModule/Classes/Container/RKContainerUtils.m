//
//  RKContainerUtils.m
//  RKMicAppContainerModule
//
//  Created by 贾晓滨 on 2021/6/29.
//

#import "RKContainerUtils.h"
#import <sys/sysctl.h>
#import <CommonCrypto/CommonCrypto.h>
#import "zlib.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <SystemConfiguration/SystemConfiguration.h>

static NSString *nsdata_to_base64_nsstring(NSData *theData) {
    
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "KLMNOPQRSTABCDEFGHIJUVWXYZabcdopqrstuvwxefghijklmnyz0123456789+/";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

static NSData* gzipData(NSData * input) {
    if (input.length == 0)
    {
        return input;
    }
    
    float level = 1.0;
    
    z_stream stream;
    stream.zalloc = Z_NULL;
    stream.zfree = Z_NULL;
    stream.opaque = Z_NULL;
    stream.avail_in = (uint)input.length;
    stream.next_in = (Bytef *)(void *)input.bytes;
    stream.total_out = 0;
    stream.avail_out = 0;
    
    static const NSUInteger ChunkSize = 16384;
    
    NSMutableData *output = nil;
    int compression = (level < 0.0f)? Z_DEFAULT_COMPRESSION: (int)(roundf(level * 9));
    if (deflateInit2(&stream, compression, Z_DEFLATED, 31, 8, Z_DEFAULT_STRATEGY) == Z_OK)
    {
        output = [NSMutableData dataWithLength:ChunkSize];
        while (stream.avail_out == 0)
        {
            if (stream.total_out >= output.length)
            {
                output.length += ChunkSize;
            }
            stream.next_out = (uint8_t *)output.mutableBytes + stream.total_out;
            stream.avail_out = (uInt)(output.length - stream.total_out);
            deflate(&stream, Z_FINISH);
        }
        deflateEnd(&stream);
        output.length = stream.total_out;
    }
    
    return output;
}

@implementation RKContainerUtils

+ (BOOL)validateString:(NSString *)string {
    BOOL result = NO;
    if (string && [string isKindOfClass:[NSString class]] && [string length] > 0) {
        result = YES;
    }
    return result;
}

+ (BOOL)validateArray:(NSArray *)array {
    BOOL result = NO;
    if (array && [array isKindOfClass:[NSArray class]] && [array count] > 0)
    {
        result = YES;
    }
    return result;
}

+ (BOOL)validateDictionary:(NSDictionary *)dictionary {
    BOOL result = NO;
    if (dictionary && [dictionary isKindOfClass:[NSDictionary class]]) {
        result = YES;
    }
    return result;
}

+ (NSString *)arrayToJson:(NSArray *)array {
    if (![[self class] validateArray:array]) {
        return nil;
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array
                                                       options:0
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil) {
        return [[NSString alloc] initWithData:jsonData
                                     encoding:NSUTF8StringEncoding];
    } else {
        return nil;
    }
}

+ (NSString *)dictionaryToJson:(NSDictionary *)dictionary {
    if (![[self class] validateDictionary:dictionary]) {
        return nil;
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:0
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil) {
        return [[NSString alloc] initWithData:jsonData
                                     encoding:NSUTF8StringEncoding];
    } else {
        return nil;
    }
}

+ (NSString *)escapeURIComponent:(NSString *)component {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CFStringEncoding cfEncoding = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
    NSString *encoded = (__bridge_transfer NSString *)
    CFURLCreateStringByAddingPercentEscapes(
                                            kCFAllocatorDefault,
                                            (__bridge CFStringRef)component,
                                            NULL,
                                            CFSTR("!#$&'()*+,/:;=?@[]"),
                                            cfEncoding);
    return encoded;
#pragma clang diagnostic pop
}

+ (NSDictionary *)specialParams {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"apple" forKey:@"client"];
//    [dic setObject:@"apple" forKey:@"d_brand"];
//    [dic setObject:[self resolution] forKey:@"screen"];
//    [dic setObject:[self osVersion] forKey:@"osVersion"];
//    [dic setObject:[self machine] forKey:@"d_model"];
    
    return dic;
}

+ (NSTimeInterval)currentTime {
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return tv.tv_sec + tv.tv_usec * 1e-6;
}

+ (unsigned long long)diffTime:(struct timeval *)tvStart endTime:(struct timeval *)tvEnd {
    return 1000000 * (tvEnd->tv_sec - tvStart->tv_sec) + tvEnd->tv_usec - tvStart->tv_usec;
}

+ (NSString *)stringForTimeVal:(struct timeval *)tv {
    if (tv) {
        return [NSString stringWithFormat:@"%lld", (long long)((tv->tv_sec + tv->tv_usec * 1e-6) * 1000)];
    } else {
        return @"";
    }
}

+ (NSString *)stringForCurrentTime {
    NSString *stringValue = [NSString stringWithFormat:@"%.6f", [self currentTime]];
    return stringValue;
}

+ (NSString *)hmacSHA256StringWithData:(NSData*)data key:(NSString *)key {
    return [self hmacStringWithData:data usingAlg:kCCHmacAlgSHA256 withKey:key];
}

+ (NSString *)hmacStringWithData:(NSData*)data usingAlg:(CCHmacAlgorithm)alg withKey:(NSString *)key {
    size_t size;
    switch (alg) {
        case kCCHmacAlgMD5: size = CC_MD5_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA1: size = CC_SHA1_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA224: size = CC_SHA224_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA256: size = CC_SHA256_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA384: size = CC_SHA384_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA512: size = CC_SHA512_DIGEST_LENGTH; break;
        default: return nil;
    }
    unsigned char result[size];
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    CCHmac(alg, cKey, strlen(cKey), data.bytes, data.length, result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:size * 2];
    for (int i = 0; i < size; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}
//压缩
+ (NSData *)gzipDeflate:(NSData*)data
{
    if ([data length] == 0) return data;
    
    z_stream strm;
    
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    strm.total_out = 0;
    strm.next_in=(Bytef *)[data bytes];
    strm.avail_in = (uInt)[data length];
    
    // Compresssion Levels:
    //   Z_NO_COMPRESSION
    //   Z_BEST_SPEED
    //   Z_BEST_COMPRESSION
    //   Z_DEFAULT_COMPRESSION
    
    if (deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15+16), 8, Z_DEFAULT_STRATEGY) != Z_OK) return nil;
    
    NSMutableData *compressed = [NSMutableData dataWithLength:16384];  // 16K chunks for expansion
    
    do {
        
        if (strm.total_out >= [compressed length])
            [compressed increaseLengthBy: 16384];
        
        strm.next_out = [compressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([compressed length] - strm.total_out);
        
        deflate(&strm, Z_FINISH);
        
    } while (strm.avail_out == 0);
    
    deflateEnd(&strm);
    
    [compressed setLength: strm.total_out];
    return [NSData dataWithData:compressed];
}

#pragma mark - json
+ (nullable NSString *)jdmk_jsonStringFromObject:(id)object{
    if (![NSJSONSerialization isValidJSONObject:object]) {
        return nil;
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
+ (nullable NSData *)jdmk_jsonDataFromObject:(id)object{
    if (![NSJSONSerialization isValidJSONObject:object]) {
        return nil;
    }
    return [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];
}
+ (nullable id)jdmk_jsonObjectFromString:(NSString *)str{
    if(![[self class] validateString:str]){
        return nil;
    }
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}
+ (nullable id)jdmk_jsonObjectFromData:(NSData *)data{
    if(data == nil){
        return nil;
    }
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

#pragma mark - network
+ (NSString *)network_type_to_string {
    RKNetworkType nt = [self current_device_cellular_and_network_type];
    NSString *net_str = @"unknown";
    switch (nt) {
        case TWO_G: {
            net_str = @"2g";
        }
            break;
        case THREE_G: {
            net_str = @"3g";
        }
            break;
        case FOUR_G: {
            net_str = @"4g";
        }
            break;
        case WIFI: {
            net_str = @"wifi";
        }
            break;
        case UNKNOWN: {
            net_str = @"unknown";
        }
            break;
        default: {
            net_str = @"unknown";
        }
            break;
    }
    return net_str;
}

+ (RKNetworkType)current_device_cellular_and_network_type {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, "8.8.8.8");
    SCNetworkReachabilityFlags flags;
    BOOL success = SCNetworkReachabilityGetFlags(reachability, &flags);
    CFRelease(reachability);
    if (!success) {
        return UNKNOWN;
    }
    BOOL isReachable = ((flags & kSCNetworkReachabilityFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkReachabilityFlagsConnectionRequired) != 0);
    BOOL isNetworkReachable = (isReachable && !needsConnection);
    
    if (!isNetworkReachable) {
        return UNKNOWN;
    } else if ((flags & kSCNetworkReachabilityFlagsIsWWAN) != 0) {
        CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
        if ([netinfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS]) {
            return TWO_G;
        } else if ([netinfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge]) {
            return TWO_G;
        } else if ([netinfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyWCDMA]) {
            return THREE_G;
        } else if ([netinfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyHSDPA]) {
            return THREE_G;
        } else if ([netinfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyHSUPA]) {
            return THREE_G;
        } else if ([netinfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMA1x]) {
            return THREE_G;
        } else if ([netinfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0]) {
            return THREE_G;
        } else if ([netinfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA]) {
            return THREE_G;
        } else if ([netinfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB]) {
            return THREE_G;
        } else if ([netinfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyeHRPD]) {
            return THREE_G;
        } else if ([netinfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
            return FOUR_G;
        } else {
            return UNKNOWN;
        }
    } else {
        return WIFI;
    }
}
#pragma mark - Crypto
+ (NSString *)string_to_md5:(NSString *)input {
    const char *cStr = [input UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), md5Buffer);
    NSMutableString *ns_str = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [ns_str appendFormat:@"%02x",md5Buffer[i]];
    return [ns_str lowercaseString];
}

+ (NSString *)string_to_gzip_base64_string:(NSString *)input {
    NSData *origData = [input dataUsingEncoding:NSUTF8StringEncoding];
    NSData *gData = gzipData(origData);
    NSString *str = nsdata_to_base64_nsstring(gData);
    return str;
}

+ (NSString *)epoch_time_string_6_digits {
    // 1566356676.545700
    return [NSString stringWithFormat:@"%.6f", [[NSDate date] timeIntervalSince1970] * 1000];
}
    
+ (NSString *)token:(NSString *)timestamp {
    NSString *str = [timestamp stringByAppendingString:[self key]];
    return [[self class] string_to_md5:str];
}

+ (NSString *)gzip_base64_compression:(NSString *)input {
    return [[self class] string_to_gzip_base64_string:input];
}

+ (NSString *)key {
    NSString *str = @"5YT%aC89$";
    return [str stringByAppendingString:@"22OI@pQ"];
}

#pragma mark - log utils
+ (void)debug_assert_objc:(NSString *)assertion {
#ifdef JDSH_DEBUG
        NSCAssert(NO, assertion);
#endif
}

+ (void)debug_nslog:(NSString *)log {
#ifdef JDSH_DEBUG
        NSLog(@"\n\n============================================================\n\n%@\n\n============================================================\n\n\n", log);
#endif
}

+ (void)catch_exception:(NSString *)info {
#ifdef JDSH_DEBUG
        NSLog(@"shooter_sdk_catch_exception_log: %@", info);
#endif
}
@end
