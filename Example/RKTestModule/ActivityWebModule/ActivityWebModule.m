//
//  ActivityWebModule.m
//
//  Created by 贾晓滨 on 2021/7/5.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "ActivityWebModule.h"
#import <RKContainerHeader.h>
#import "ActivityWebService.h"

@RKModule(ActivityWebModule)
@interface ActivityWebModule () <RKModuleProtocol>

@end
@implementation ActivityWebModule

- (void)kAfterFinishLaunching {
    [[RKContainer sharedInstance] registService:[ActivityWebService class]
                                      forProtocol:@protocol(RKActivityWebProtocol)];
}

@end
