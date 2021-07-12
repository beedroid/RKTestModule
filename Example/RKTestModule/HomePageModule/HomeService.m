//
//  HomeService.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/2.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "HomeService.h"
#import "HomeTabBarController.h"
#import <RKContainerHeader.h>

@interface HomeService () <RKHomePageProtocol>

@end
@implementation HomeService
- (nonnull UIViewController *)entryPage {
    return [[HomeTabBarController alloc] init];
}

@end
