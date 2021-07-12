//
//  RKServiceProtocol.h
//  RKMicAppContainerModule
//
//  Created by 贾晓滨 on 2021/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RKServiceProtocol <NSObject>

@optional

+ (BOOL)singleton;

+ (id)shareInstance;

@end

NS_ASSUME_NONNULL_END
