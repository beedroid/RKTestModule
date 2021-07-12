//
//  NetworkService.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/2.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "NetworkService.h"
#import <RKContainerHeader.h>

@interface NetworkService () <RKNetworkProtocol>

@end

@implementation NetworkService
- (void)getWithSuccess:(void(^)(NSString *result))succeesBlcok
                 error:(void(^)(NSString *errorInfo))errorBlock{
    succeesBlcok(@"network lib1：get Success!");
}
- (void)postWithSuccess:(void(^)(NSString *result))succeesBlcok
                  error:(void(^)(NSString *errorInfo))errorBlock{
    succeesBlcok(@"network lib1：post Success!");
}
@end
