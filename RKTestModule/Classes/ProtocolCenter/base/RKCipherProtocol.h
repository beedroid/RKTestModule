//
//  RKCipherProtocol.h
//  RKMicAppContainerModule
//
//  Created by 贾晓滨 on 2021/6/29.
//

#import <Foundation/Foundation.h>
#import "RKServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RKCipherProtocol <NSObject, RKServiceProtocol>
- (NSString *)md5:(NSString *)content;
@end

NS_ASSUME_NONNULL_END
