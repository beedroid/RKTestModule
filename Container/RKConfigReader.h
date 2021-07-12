//
//  RKConfigReader.h
//  AFNetworking
//
//  Created by 贾晓滨 on 2021/7/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RKConfigReader : NSObject

+ (NSMutableArray *)readConfigFromSectionName:(NSString *)sectionName;

@end

NS_ASSUME_NONNULL_END
