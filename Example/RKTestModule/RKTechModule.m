//
//  RKTechModule.m
//  RKTestModule_Example
//
//  Created by 贾晓滨 on 2021/7/11.
//  Copyright © 2021 beedroid. All rights reserved.
//

#import "RKTechModule.h"
#import <RKContainerHeader.h>
#import "RKTechService.h"

@RKModule(RKTechModule)
@interface RKTechModule () <RKModuleProtocol>

@end
@implementation RKTechModule

- (void)kBeforeDidFinishLaunching {
    [[RKContainer sharedInstance] registService:[RKTechService class]
                                      forProtocol:@protocol(RKTechProtocol)];
    
}

@end
