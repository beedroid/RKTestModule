//
//  DeviceInfoService.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/2.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "DeviceInfoService.h"
#import <RKContainerHeader.h>

@interface DeviceInfoService() <RKDeviceInfoProtocol> {
    NSString *_UUID;
}
@end

@implementation DeviceInfoService

- (NSString *)UUID{
    return _UUID;
}
- (void)setUUID:(NSString *)uuid{
    _UUID = uuid;
}

@end
