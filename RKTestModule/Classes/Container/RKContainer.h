//
//  RKContainer.h
//  RKMicAppContainerModule
//
//  Created by 贾晓滨 on 2021/6/29.
//

#import <Foundation/Foundation.h>
#import "RKContext.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RKEventType){
    RKBeforeDidFinishLaunchingEvent,
    RKDidFinishLaunchingEvent,
    RKAfterFinishLaunchingEvent,
    
    RKDidEnterBackgroundEvent,
    RKWillEnterForegroundEvent,
    RKDidBecomeActiveEvent,
    RKWillTerminateEvent
};

@class RKContext;

@interface RKContainer : NSObject
@property (nonatomic, strong) RKContext *context;

+ (instancetype)sharedInstance;
- (void)configEnv:(RKEnvType)envType;
- (void)loadAllModuleAndService;
- (void)configRootVC:(UINavigationController *)rootVC;
- (void)registModule:(Class)moduleClass;
- (void)registService:(Class)serviceClass forProtocol:(Protocol *)protocol;
- (id)loadServiceForProtocol:(Protocol *)protocol;
- (void)dispatchEvent:(RKEventType)eventType;

@end

NS_ASSUME_NONNULL_END
