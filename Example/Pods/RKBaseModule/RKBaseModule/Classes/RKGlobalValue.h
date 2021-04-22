//
//  RKGlobalValue.h
//  RKBaseModule
//
//  Created by 贾晓滨 on 2020/1/2.
//

#import <Foundation/Foundation.h>
#import "RKGlobal.h"

NS_ASSUME_NONNULL_BEGIN
/**
 【单例】全局配置项 - 统一管理需要跨模块同步的数据及逻辑
 */
@interface RKGlobalValue : NSObject
AS_SINGLETON(RKGlobalValue)

// 应用启动时调用服务端接口获取时间，通过该方法校准客户端时间
- (void)timeCorrect:(NSTimeInterval)serverTime;
@property (nonatomic, readonly) NSDate *serverDate;
@property (nonatomic, getter = isFirstLaunch) BOOL firstLaunchOfNewVersion;
@property (nonatomic, getter = isActiveLaunch) BOOL firstLaunchAfterInstall;
@property (nonatomic, copy) NSNumber *locatedCityId;
@property (nonatomic, copy) NSNumber *useWebp;           //是否使用webp图片
@end

NS_ASSUME_NONNULL_END
