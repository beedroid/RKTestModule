//
//  RKKeychain.h
//  RKBaseModule
//
//  Created by 贾晓滨 on 2020/1/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RKKeychain : NSObject
+ (void)setKeychainValue:(id<NSCopying, NSObject>)value forType:(NSString *)type;
+ (id)getKeychainValueForType:(NSString *)type;
+ (void)reset;
@end

NS_ASSUME_NONNULL_END
