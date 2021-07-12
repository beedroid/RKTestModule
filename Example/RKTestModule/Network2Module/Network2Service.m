//
//  Network2Service.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/2.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "Network2Service.h"
#import <RKContainerHeader.h>

@interface Network2Service () <RKNetworkProtocol>

@end

@implementation Network2Service
- (void)getWithSuccess:(void(^)(NSString *result))succeesBlcok
                 error:(void(^)(NSString *errorInfo))errorBlock{
    succeesBlcok(@"network lib2：Get Success!");
}
- (void)postWithSuccess:(void(^)(NSString *result))succeesBlcok
                  error:(void(^)(NSString *errorInfo))errorBlock{
    succeesBlcok(@"network lib2：Post Success!");
}
@end
