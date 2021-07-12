//
//  DeviceInfoService.h
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/2.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceInfoService : NSObject
- (NSString *)UUID;
- (void)setUUID:(NSString *)uuid;
@end

NS_ASSUME_NONNULL_END
