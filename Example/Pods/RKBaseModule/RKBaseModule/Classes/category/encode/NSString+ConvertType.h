//
//  NSString+ConvertType.h
//  RKBaseModule
//
//  Created by 贾晓滨 on 2020/1/2.
//

#import <Foundation/Foundation.h>

@interface NSString (ConvertType)

+(NSString *) unicodeToUtf8:(NSString *)string;
+(NSString *) utf8ToUnicode:(NSString *)string;
//"#fff303"色值转16进制
- (unsigned long)sixteenBinarySystem;

@end
