//
//  DiscoverModule.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/3.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "DiscoverModule.h"
#import <RKContainerHeader.h>
#import "DiscoverService.h"
#import "DiscoverViewController.h"

@RKModule(DiscoverModule)
@interface DiscoverModule () <RKModuleProtocol>

@end

@implementation DiscoverModule

- (void)kBeforeDidFinishLaunching {
    [[RKContainer sharedInstance] registService:[DiscoverService class]
                                      forProtocol:@protocol(RKDiscoverProtocol)];
    
}

@end
