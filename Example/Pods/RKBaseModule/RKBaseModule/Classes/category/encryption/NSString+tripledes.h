//
//  NSString+tripledes.h
//  RKBaseModule
//
//  Created by 贾晓滨 on 2020/1/2.
//

#import <Foundation/Foundation.h>

@interface NSString (tripledes)

//加密hciToken数据
+ (NSString*)getHciTokenTripleDESStringWithDictionary:(NSMutableDictionary*)hciTekonDictionary;

@end
