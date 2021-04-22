//
//  JSONValueTransformer+CustomTransformer.m
//  RKBaseModule
//
//  Created by 贾晓滨 on 2020/1/2.
//

#import <JSONModel/JSONModel.h>
//category
#import "NSObject+swizzle.h"
#import "NSString+safe.h"

@implementation JSONValueTransformer(CustomTransformer)

+ (void)load
{
    [self exchangeMethod:@selector(NSDateFromNSNumber:) withMethod:@selector(NSDateFromNSNumberDivide1000:)];
}

#pragma mark - number <-> date
- (NSDate*)NSDateFromNSNumberDivide1000:(NSNumber*)number;
{
	return [NSDate dateWithTimeIntervalSince1970:number.doubleValue / 1000];
}

#pragma mark- date->number
-(NSNumber*)JSONObjectFromNSDate:(NSDate*)date
{
	return  @((date.timeIntervalSince1970 * 1000));
}

#pragma mark - string <-> date
-(NSDate*)NSDateFromNSString:(NSString*)string
{
	NSDate *dateValue = nil;
	NSString *formatStr = @"yyyy-MM-dd HH:mm:ss";
	NSString *dateStr = (NSString *)string;
	NSInteger length = [formatStr length];
	if (dateStr.length >= length) {
		if ([dateStr safeRangeOfString:@"UTC"].location!=NSNotFound || [dateStr safeRangeOfString:@"GMT"].location!=NSNotFound) {
			NSString *subStr = [dateStr safeSubstringWithRange:NSMakeRange(0, length)];
			NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
			[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
			[dateFormatter setDateFormat:formatStr];
			dateValue = [dateFormatter dateFromString:subStr];
		} else {
			NSString *subStr = [dateStr safeSubstringWithRange:NSMakeRange(0, length)];
			NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
			[dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
			[dateFormatter setDateFormat:formatStr];
			dateValue = [dateFormatter dateFromString:subStr];
		}
	}
	if (dateValue == nil) {
		dateValue = [NSDate date];
	}
	return dateValue;
}
@end
