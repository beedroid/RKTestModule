//
//  CipherModule.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/6/29.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "CipherModule.h"
#import <RKContainerHeader.h>
#import "CipherService.h"
#import "Cipher2Service.h"

@RKModule(CipherModule)
@interface CipherModule () <RKModuleProtocol>

@end

@implementation CipherModule
- (void)kBeforeDidFinishLaunching{
    [[RKContainer sharedInstance] registService:[CipherService class]
                                      forProtocol:@protocol(RKCipherProtocol)];
//    [[RKContainer sharedInstance] registService:[Cipher2Service class]
//                                      forProtocol:@protocol(RKCipherProtocol)];
}


- (void)kDidFinishLaunching{
    NSLog(@"CipherModule - DidEnterBackground");
}
- (void)kWillEnterForeground{
    NSLog(@"CipherModule - WillEnterForeground");
}

@end
