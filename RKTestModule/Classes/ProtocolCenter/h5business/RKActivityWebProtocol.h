//
//  RKActivityWebProtocol.h
//  RKMicAppContainerModule
//
//  Created by 贾晓滨 on 2021/7/5.
//

#import <Foundation/Foundation.h>
#import "RKServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RKActivityWebProtocol <NSObject, RKServiceProtocol>
@required
- (UIViewController *)entryPage;
@end

NS_ASSUME_NONNULL_END
