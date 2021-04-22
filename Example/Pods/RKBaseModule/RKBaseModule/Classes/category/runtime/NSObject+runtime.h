//
//  NSObject+runtime.h
//  RKBaseModule
//
//  Created by 贾晓滨 on 2020/1/2.
//

#import <Foundation/Foundation.h>

@interface NSObject (runtime)

/**
 *  获取对象的所有属性
 *
 *  @return 属性dict
 */
- (NSArray *)getProperties;

@end
