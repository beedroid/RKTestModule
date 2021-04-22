//
//  NSMutableDictionary+safe.m
//  RKBaseModule
//
//  Created by 贾晓滨 on 2020/1/2.
//

#import "NSMutableDictionary+safe.h"
#import "NSObject+swizzle.h"

@implementation NSMutableDictionary(safe)

+ (void)load
{
    [self overrideMethod:@selector(setObject:forKeyedSubscript:) withMethod:@selector(safeSetObject:forKeyedSubscript:)];
}

- (void)safeSetObject:(id)obj forKeyedSubscript:(id<NSCopying>)key
{
    if (!key) {
        return ;
    }

    if (!obj) {
        [self removeObjectForKey:key];
    }
    else {
        [self setObject:obj forKey:key];
    }
}

- (void)safeSetObject:(id)aObj forKey:(id<NSCopying>)aKey
{
    if (aObj && aKey) {
        [self setObject:aObj forKey:aKey];
    } else {
        return;
    }
}


@end
