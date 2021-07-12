//
//  ActivityWebService.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/5.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "ActivityWebService.h"
#import <RKContainerHeader.h>
#import "ActivityWebViewController.h"

@interface ActivityWebService () <RKActivityWebProtocol>

@end
@implementation ActivityWebService
- (UIViewController *)entryPage{
    return [[ActivityWebViewController alloc] init];
}
@end
