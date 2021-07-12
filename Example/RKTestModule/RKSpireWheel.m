//
//  RKSpireWheel.m
//  RKTestModule_Example
//
//  Created by 贾晓滨 on 2021/6/17.
//  Copyright © 2021 beedroid. All rights reserved.
//

#import "RKSpireWheel.h"

@implementation RKSpireWheel

- (void)sayMessage3:(NSString *)msg{
    NSLog(@"RKSpireWheel<forwardingTargetForSelector 快转> say:%@", msg);
}

- (void)sayMessage4:(NSString *)msg{
    NSLog(@"RKSpireWheel<forwardInvocation 慢转> say:%@", msg);
}

@end
