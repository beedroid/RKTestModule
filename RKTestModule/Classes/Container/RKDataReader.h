//
//  RKDataReader.h
//  RKMicAppContainerModule
//
//  Created by 贾晓滨 on 2021/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RKDataReader : NSObject

+ (NSMutableArray *)readConfigFromSectionName:(NSString *)sectionName;

@end

NS_ASSUME_NONNULL_END
