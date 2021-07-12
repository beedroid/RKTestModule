//
//  MineModule.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/3.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "MineModule.h"
#import <RKContainerHeader.h>
#import "MineService.h"
#import "MineViewController.h"

@RKModule(MineModule)
@interface MineModule () <RKModuleProtocol>

@end

@implementation MineModule

- (void)kBeforeDidFinishLaunching {
    [[RKContainer sharedInstance] registService:[MineService class]
                                      forProtocol:@protocol(RKMineProtocol)];
    
}

@end
