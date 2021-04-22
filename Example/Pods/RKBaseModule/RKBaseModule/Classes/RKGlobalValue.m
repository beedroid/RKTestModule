//
//  RKGlobalValue.m
//  RKBaseModule
//
//  Created by 贾晓滨 on 2020/1/2.
//

#import "RKGlobalValue.h"
#import "RKGlobal.h"
#import "RKKeychain.h"
#import "RKUserDefault.h"
#import "NSNumber+safe.h"

NSString *const KeyChainSignatureKey = @"keychain.signatureKey";
NSString *const RK_KEYCHAIN_ISACTIVE   = @"RK_KEYCHAIN_ISACTIVE";
NSString *const RK_DEF_KEY_LAST_RUN_VERSION          = @"RK_DEF_KEY_LAST_RUN_VERSION";

@interface RKGlobalValue()
@property (nonatomic, assign) NSTimeInterval baseServerTime;
@property (nonatomic, assign) NSTimeInterval deviceStartTime;
@end

@implementation RKGlobalValue
@synthesize locatedCityId = _locatedCityId;

DEF_SINGLETON(RKGlobalValue);

- (instancetype)init
{
    if (self = [super init]) {
        
        NSNumber *isActive = [RKKeychain getKeychainValueForType:RK_KEYCHAIN_ISACTIVE];
        if (!isActive.boolValue) {
            self.firstLaunchAfterInstall = YES;
            [RKKeychain setKeychainValue:@(YES) forType:RK_KEYCHAIN_ISACTIVE];
        }
        
        //是否新版本第一次启动
        NSString *lastRunVersion = [RKUserDefault getValueForKey:RK_DEF_KEY_LAST_RUN_VERSION];
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
        if (!lastRunVersion || ![lastRunVersion isEqualToString:currentVersion]) {
            self.firstLaunchOfNewVersion = YES;
            [RKUserDefault setValue:currentVersion forKey:RK_DEF_KEY_LAST_RUN_VERSION];
        } else {
            self.firstLaunchOfNewVersion = NO;
        }
        
        
    }
    return self;
}

- (void)timeCorrect:(NSTimeInterval)serverTime{
    self.baseServerTime = serverTime;
    self.deviceStartTime = [[NSProcessInfo processInfo] systemUptime];
}

- (NSDate *)serverDate{
    if (self.baseServerTime == 0) {
        return [NSDate date];
    }
    NSTimeInterval outTime = [[NSProcessInfo processInfo] systemUptime] - self.deviceStartTime;
    NSDate *serverDate = [NSDate dateWithTimeIntervalSince1970:self.baseServerTime + outTime];
    return serverDate;
}

- (NSNumber *)locatedCityId
{
    if (_locatedCityId == nil) {
        _locatedCityId = [RKUserDefault getValueForKey:@"RK_DEF_KEY_LOCATED_CITYID"];
        if(_locatedCityId == nil){
            _locatedCityId = @-1;
        }
    }
    return _locatedCityId;
}

- (void)setLocatedCityId:(NSNumber *)locatedCityId
{
    if ([locatedCityId safeIsEqualToNumber:_locatedCityId]) {
            return;
        }
    _locatedCityId = @(locatedCityId.integerValue);
    [RKUserDefault setValue:locatedCityId forKey:@"RK_DEF_KEY_LOCATED_CITYID"];
}
@end
