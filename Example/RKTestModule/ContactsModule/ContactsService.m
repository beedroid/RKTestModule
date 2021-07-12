//
//  ContactsService.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/3.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "ContactsService.h"
#import "ContactsViewController.h"
#import <RKContainerHeader.h>


@interface ContactsService () <RKContactsProtocol>

@end

@implementation ContactsService

- (UIViewController *)entryPage{
    return [[ContactsViewController alloc] init];
}

@end
