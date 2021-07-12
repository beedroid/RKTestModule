//
//  NetworkModule.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/6/29.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "NetworkModule.h"
#import <RKContainerHeader.h>
#import "NetworkService.h"

//@RKModule(NetworkModule)
@interface NetworkModule () <RKModuleProtocol>

@end

@implementation NetworkModule

- (void)kBeforeDidFinishLaunching{
    [[RKContainer sharedInstance] registService:[NetworkService class]
                                      forProtocol:@protocol(RKNetworkProtocol)];
}

- (void)kDidFinishLaunching{
    NSLog(@"DeviceInfoModule - DidEnterBackground");
}
- (void)kWillEnterForeground{
    NSLog(@"DeviceInfoModule - WillEnterForeground");
}

@end
