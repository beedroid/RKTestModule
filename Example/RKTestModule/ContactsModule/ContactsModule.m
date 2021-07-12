//
//  ContactsModule.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/3.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "ContactsModule.h"
#import <RKContainerHeader.h>
#import "ContactsService.h"
#import "ContactsViewController.h"

@RKModule(ContactsModule)
@interface ContactsModule () <RKModuleProtocol>

@end

@implementation ContactsModule

- (void)kBeforeDidFinishLaunching {
    [[RKContainer sharedInstance] registService:[ContactsService class]
                                      forProtocol:@protocol(RKContactsProtocol)];
    
}

@end
