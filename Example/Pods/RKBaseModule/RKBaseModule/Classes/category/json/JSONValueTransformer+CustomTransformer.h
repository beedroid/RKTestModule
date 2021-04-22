//
//  JSONValueTransformer+CustomTransformer.h
//  RKBaseModule
//
//  Created by 贾晓滨 on 2020/1/2.
//

#import <JSONModel/JSONValueTransformer.h>

@interface JSONValueTransformer(CustomTransformer)

-(NSDate*)NSDateFromNSString:(NSString*)string;

-(NSNumber*)JSONObjectFromNSDate:(NSDate*)date;

@end
