//
//  RKTechProtocol.h
//  RKTestModule
//
//  Created by 贾晓滨 on 2021/7/11.
//

#import <Foundation/Foundation.h>
#import "RKServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RKTechProtocol <NSObject, RKServiceProtocol>

@required
- (UIViewController *)entryPage;

@end

NS_ASSUME_NONNULL_END
