//
//  RKModuleProtocol.h
//  RKMicAppContainerModule
//
//  Created by 贾晓滨 on 2021/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RKModuleProtocol <NSObject>

@optional
//- APP启动事件
- (void)kBeforeDidFinishLaunching;
- (void)kDidFinishLaunching;
- (void)kAfterFinishLaunching;
//- 系统事件
- (void)kDidEnterBackground;
- (void)kWillEnterForeground;
- (void)kDidBecomeActive;
- (void)kWillTerminate;

@end

NS_ASSUME_NONNULL_END
