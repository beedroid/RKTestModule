//
//  Network2Module.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/2.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "Network2Module.h"
#import <RKContainerHeader.h>
#import "Network2Service.h"

@RKModule(Network2Module)
@interface Network2Module () <RKModuleProtocol>

@end

@implementation Network2Module

- (void)kBeforeDidFinishLaunching{
    [[RKContainer sharedInstance] registService:[Network2Service class]
                                      forProtocol:@protocol(RKNetworkProtocol)];
}

- (void)kDidFinishLaunching{
    NSLog(@"DeviceInfoModule - DidEnterBackground");
}
- (void)kWillEnterForeground{
    NSLog(@"DeviceInfoModule - WillEnterForeground");
}

@end
