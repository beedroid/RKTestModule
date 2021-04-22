//
//  RKUserDefault.h
//  RKBaseModule
//
//  Created by 贾晓滨 on 2020/1/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RKUserDefault : NSObject
+ (void)setValue:(id)anObject forKey:(NSString *)aKey;
+ (id)getValueForKey:(NSString *)aKey;
+ (void)setBool:(BOOL)value forKey:(NSString *)aKey;
+ (BOOL)getBoolValueForKey:(NSString *)aKey;
@end

NS_ASSUME_NONNULL_END
