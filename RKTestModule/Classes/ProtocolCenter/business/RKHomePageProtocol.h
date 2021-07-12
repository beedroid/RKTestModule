//
//  RKHomePageProtocol.h
//  RKMicAppContainerModule
//
//  Created by 贾晓滨 on 2021/7/2.
//

#import <Foundation/Foundation.h>
#import "RKServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RKHomePageProtocol <NSObject, RKServiceProtocol>
@required
- (UIViewController *)entryPage;
@end

NS_ASSUME_NONNULL_END
