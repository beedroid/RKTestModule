//
//  ChatService.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/3.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "ChatService.h"
#import "ChatViewController.h"
#import <RKContainerHeader.h>


@interface ChatService () <RKChatProtocol>

@end

@implementation ChatService

- (UIViewController *)entryPage{
    return [[ChatViewController alloc] init];
}
@end
