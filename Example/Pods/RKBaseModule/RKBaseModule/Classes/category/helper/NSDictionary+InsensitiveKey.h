//
//  NSDictionary+InsensitiveKey.h
//  RKBaseModule
//
//  Created by beedroid on 01/02/2020.
//  Copyright (c) 2020 beedroid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (InsensitiveKey)

/**
 *  忽略key大小写查询字典
 *
 *  @param aKey
 *
 *  @return
 */
- (id)objectForCaseInsensitiveKey:(NSString *)aKey;

@end
