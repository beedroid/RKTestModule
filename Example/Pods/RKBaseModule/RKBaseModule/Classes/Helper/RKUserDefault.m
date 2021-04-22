//
//  RKUserDefault.m
//  RKBaseModule
//
//  Created by 贾晓滨 on 2020/1/2.
//
#import "RKUserDefault.h"

@implementation RKUserDefault

+ (void)setValue:(id)anObject forKey:(NSString *)aKey
{
    if ( ! aKey || ! [aKey isKindOfClass:[NSString class]]) {
        return ;
    }
    
    if (anObject)
    {
        [[NSUserDefaults standardUserDefaults] setObject:anObject forKey:aKey];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:aKey];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)getValueForKey:(NSString *)aKey
{
    if ( ! aKey || ! [aKey isKindOfClass:[NSString class]]) {
        return nil;
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:aKey];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)aKey {
    
    if ( ! aKey || ! [aKey isKindOfClass:[NSString class]]) {
        return ;
    }
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:aKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)getBoolValueForKey:(NSString *)aKey {
    if ( ! aKey || ! [aKey isKindOfClass:[NSString class]]) {
        return nil;
    }
    return [[NSUserDefaults standardUserDefaults] boolForKey:aKey];
}
@end
