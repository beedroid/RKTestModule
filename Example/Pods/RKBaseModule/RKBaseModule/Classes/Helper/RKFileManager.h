//
//  RKFileManager.h
//  RKBaseModule
//
//  Created by 贾晓滨 on 2020/1/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 文件管理辅助类
*/

@interface RKFileManager : NSObject
+ (NSString *)appDocPath;
+ (NSString *)appCachePath;
+ (NSString *)appLibPath;
+ (BOOL)isFileExsit:(NSString *)aPath;
+ (BOOL)isFileExsitInDoc:(NSString *)aPath;
+ (BOOL)isBundleExsit:(NSString *)aBundleName;
@end

NS_ASSUME_NONNULL_END
