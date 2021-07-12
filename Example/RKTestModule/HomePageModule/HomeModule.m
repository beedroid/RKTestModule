//
//  HomeModule.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/2.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "HomeModule.h"
#import <RKContainerHeader.h>
#import "HomeService.h"
#import "HomeTabBarController.h"

@RKModule(HomeModule)
@interface HomeModule () <RKModuleProtocol>

@end

@implementation HomeModule
- (void)kBeforeDidFinishLaunching {
    [[RKContainer sharedInstance] registService:[HomeService class]
                                      forProtocol:@protocol(RKHomePageProtocol)];
    
}

- (void)kDidFinishLaunching {
    HomeTabBarController *homePage = [[HomeTabBarController alloc] init];
    [[RKContainer sharedInstance].context.rootVC pushViewController:homePage animated:YES];
}

- (void)kWillEnterForeground {
    NSLog(@"HomePageModule - WillEnterForeground");
}
@end
