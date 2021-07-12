//
//  ChatModule.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/3.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "ChatModule.h"
#import <RKContainerHeader.h>
#import "ChatService.h"
#import "ChatViewController.h"

@RKModule(ChatModule)
@interface ChatModule () <RKModuleProtocol>

@end


@implementation ChatModule

- (void)kBeforeDidFinishLaunching {
    [[RKContainer sharedInstance] registService:[ChatService class]
                                      forProtocol:@protocol(RKChatProtocol)];
    
}

@end
