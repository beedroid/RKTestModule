//
//  Cipher2Service.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/2.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "Cipher2Service.h"
#import <RKContainerHeader.h>

@interface Cipher2Service () <RKCipherProtocol>

@end

@implementation Cipher2Service
- (NSString *)md5:(NSString *)content{
    return [NSString stringWithFormat:@"MD5方式二：[%@]", content];
}
@end
