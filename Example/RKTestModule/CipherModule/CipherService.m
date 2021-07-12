//
//  CipherService.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/2.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "CipherService.h"
#import <RKContainerHeader.h>

@interface CipherService () <RKCipherProtocol>

@end

@implementation CipherService
- (NSString *)md5:(NSString *)content{
    return [NSString stringWithFormat:@"MD5方式一：[%@]", content];
}
@end
