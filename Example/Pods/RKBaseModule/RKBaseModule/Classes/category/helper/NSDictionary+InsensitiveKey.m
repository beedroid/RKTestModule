//
//  NSDictionary+router.m
//  RKBaseModule
//
//  Created by beedroid on 01/02/2020.
//  Copyright (c) 2020 beedroid. All rights reserved.
//

#import "NSDictionary+InsensitiveKey.h"

@implementation NSDictionary (InsensitiveKey)

- (id)objectForCaseInsensitiveKey:(NSString *)aKey
{
    if (!aKey) {
        return nil;
    }
    
    __block id returnObj = nil;
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *tempKey = key;
        if ([tempKey compare:aKey options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            returnObj = obj;
            *stop = YES;
        }
    }];
    
    return returnObj;
}

@end
