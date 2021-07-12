//
//  RKContext.h
//  RKMicAppContainerModule
//
//  Created by 贾晓滨 on 2021/7/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RKEnvType){
    RKEnvTypeDebug,
    RKEnvTypePre,
    RKEnvTypeRelease
};

@interface RKContext : NSObject
@property (nonatomic, assign) RKEnvType env;
@property (nonatomic, strong) UINavigationController *rootVC;
@end

NS_ASSUME_NONNULL_END
