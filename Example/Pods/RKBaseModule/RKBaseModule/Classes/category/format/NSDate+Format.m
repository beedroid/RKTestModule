//
//  NSDate+Format.m
//  RKBaseModule
//
//  Created by 贾晓滨 on 2020/1/2.
//
#import "NSDate+Format.h"

@implementation NSDate (Format)

/**
 *  把日期转化为yyyy/MM/dd
 *
 *  @return 转化后的字符串
 */
-(NSString *)dateToString_yyyyMMdd{
    
    if ([self isKindOfClass:[NSDate class]])
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
          dateFormatter.timeZone = [NSTimeZone localTimeZone];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        
        NSString *anString = [dateFormatter stringFromDate:(NSDate *)self];
        
        return anString;
    }
    
    return nil;
}


/**
 *  把日期转化为yyyy-MM-dd
 *
 *  @return 转化后的字符串
 */
-(NSString *)dateToString_yyyyMMdd1{
    
    if ([self isKindOfClass:[NSDate class]])
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
         dateFormatter.timeZone = [NSTimeZone localTimeZone];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *anString = [dateFormatter stringFromDate:(NSDate *)self];
        
        return anString;
    }
    
    return nil;
}

/**
 *  把日期转化为yyyy-MM-dd HH:mm
 *
 *  @return 转化后的字符串
 */
-(NSString *)dateToString_yyyyMMddHHmm {
    if ([self isKindOfClass:[NSDate class]])
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
         dateFormatter.timeZone = [NSTimeZone localTimeZone];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        
        NSString *anString = [dateFormatter stringFromDate:(NSDate *)self];
        
        return anString;
    }
    
    return nil;
}

@end
