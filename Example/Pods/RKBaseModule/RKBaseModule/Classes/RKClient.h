//
//  RKClient.h
//  RKBaseModule
//
//  Created by 贾晓滨 on 2020/1/2.
//

#import <Foundation/Foundation.h>
#import "RKGlobal.h"

NS_ASSUME_NONNULL_BEGIN

/**
 [单例]客户端信息类
 */

@interface RKClient : NSObject
AS_SINGLETON(RKClient)

@property (nonatomic, copy) NSString *clientAppVersion;     // 客户端app版本号
@property (nonatomic, copy) NSString *clientSystem;         // 客户端系统类型ipad or iphone
@property (nonatomic, copy) NSString *clientVersion;        // 客户端版本
@property (nonatomic, copy) NSString *idfa;
@property (nonatomic, copy) NSString *deviceCode;           // 设备号
@property (nonatomic, copy) NSString *phoneType;            // 设备号
@property (nonatomic, copy) NSString *unionKey;             // 渠道id
@property (nonatomic, copy) NSNumber *latitude;             // 纬度
@property (nonatomic, copy) NSNumber *longitude;            // 经度
@end

NS_ASSUME_NONNULL_END
