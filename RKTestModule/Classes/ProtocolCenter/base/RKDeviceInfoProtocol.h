//
//  RKDeviceInfoProtocol.h
//  RKMicAppContainerModule
//
//  Created by 贾晓滨 on 2021/6/29.
//

#import <Foundation/Foundation.h>
#import "RKServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RKDeviceInfoProtocol <NSObject, RKServiceProtocol>
- (NSString *)UUID;
- (void)setUUID:(NSString *)uuid;
@end

NS_ASSUME_NONNULL_END
