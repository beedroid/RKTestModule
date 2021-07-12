//
//  MineService.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/3.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "MineService.h"
#import "MineViewController.h"
#import <RKContainerHeader.h>


@interface MineService () <RKMineProtocol>

@end

@implementation MineService

- (UIViewController *)entryPage{
    return [[MineViewController alloc] init];
}
@end
