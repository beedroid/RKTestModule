//
//  DeviceInfoModule.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/6/29.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "DeviceInfoModule.h"
#import <RKContainerHeader.h>
#import "DeviceInfoService.h"

@RKModule(DeviceInfoModule)
@interface DeviceInfoModule () <RKModuleProtocol>

@end

@implementation DeviceInfoModule

- (void)kAfterFinishLaunching{
    [[RKContainer sharedInstance] registService:[DeviceInfoService class]
                                      forProtocol:@protocol(RKDeviceInfoProtocol)];
    
}

- (void)kDidFinishLaunching{
    NSLog(@"DeviceInfoModule - DidEnterBackground");
}
- (void)kWillEnterForeground{
    NSLog(@"DeviceInfoModule - WillEnterForeground");
}

@end
