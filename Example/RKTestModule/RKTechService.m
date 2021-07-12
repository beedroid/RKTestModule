//
//  RKTechService.m
//  RKTestModule_Example
//
//  Created by 贾晓滨 on 2021/7/11.
//  Copyright © 2021 beedroid. All rights reserved.
//

#import "RKTechService.h"
#import <RKContainerHeader.h>
#import "RKHomeViewController.h"

@interface RKTechService () <RKTechProtocol>

@end

@implementation RKTechService

- (UIViewController *)entryPage{
    return [[RKHomeViewController alloc] init];
}

@end
