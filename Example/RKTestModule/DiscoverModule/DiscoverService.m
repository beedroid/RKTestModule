//
//  DiscoverService.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/3.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "DiscoverService.h"
#import "DiscoverViewController.h"
#import <RKContainerHeader.h>


@interface DiscoverService () <RKDiscoverProtocol>

@end

@implementation DiscoverService
- (UIViewController *)entryPage{
    return [[DiscoverViewController alloc] init];
}
@end
