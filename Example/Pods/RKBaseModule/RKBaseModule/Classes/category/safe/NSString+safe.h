//
//  NSString+safe.h
//  RKBaseModule
//
//  Created by 贾晓滨 on 2020/1/2.
//

#import <Foundation/Foundation.h>

@interface NSString (safe)

- (NSString *)safeSubstringFromIndex:(NSUInteger)from;

- (NSString *)safeSubstringToIndex:(NSUInteger)to;

- (NSString *)safeSubstringWithRange:(NSRange)range;

- (NSRange)safeRangeOfString:(NSString *)aString;

- (NSRange)safeRangeOfString:(NSString *)aString options:(NSStringCompareOptions)mask;

- (NSString *)safeStringByAppendingString:(NSString *)aString;

- (id)safeInitWithString:(NSString *)aString;

+ (id)safeStringWithString:(NSString *)string;

@end
