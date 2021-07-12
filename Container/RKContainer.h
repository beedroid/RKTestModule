//
//  RKContainer.h
//  AFNetworking
//
//  Created by 贾晓滨 on 2021/7/10.
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
+ (id)sharedInstance;
- (void)configEnv:(RKEnvType)envType;
- (void)loadAllModuleAndService;
- (void)configRootNav:(UINavigationController *)rootNav;
- (void)registModule:(Class)moduleClass;
- (void)registService:(Class)serviceClass forProtocol:(Protocol *)protocol;
- (id)loadServiceForProtocol:(Protocol *)protocol;
- (void)dispatchEvent:(RKEventType)eventType;
@end

NS_ASSUME_NONNULL_END
