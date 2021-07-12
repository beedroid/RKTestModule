//
//  RKContext.h
//  AFNetworking
//
//  Created by 贾晓滨 on 2021/7/10.
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
@property (nonatomic, strong) UINavigationController *rootNav;
@end

NS_ASSUME_NONNULL_END
