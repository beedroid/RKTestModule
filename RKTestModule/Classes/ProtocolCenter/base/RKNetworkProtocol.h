//
//  RKNetworkProtocol.h
//  RKMicAppContainerModule
//
//  Created by 贾晓滨 on 2021/6/29.
//

#import <Foundation/Foundation.h>
#import "RKServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RKNetworkProtocol <NSObject, RKServiceProtocol>
- (void)getWithSuccess:(void(^)(NSString *result))succeesBlcok
                 error:(void(^)(NSString *errorInfo))errorBlock;
- (void)postWithSuccess:(void(^)(NSString *result))succeesBlcok
                  error:(void(^)(NSString *errorInfo))errorBlock;
@end

NS_ASSUME_NONNULL_END
