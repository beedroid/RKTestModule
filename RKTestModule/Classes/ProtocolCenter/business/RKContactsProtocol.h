//
//  RKContactsProtocol.h
//  RKMicAppContainerModule
//
//  Created by 贾晓滨 on 2021/7/3.
//

#import <Foundation/Foundation.h>
#import "RKServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RKContactsProtocol <NSObject, RKServiceProtocol>

@required
- (UIViewController *)entryPage;

@end

NS_ASSUME_NONNULL_END
