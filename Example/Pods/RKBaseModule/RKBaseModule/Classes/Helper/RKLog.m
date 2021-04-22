//
//  RKLog.m
//  RKBaseModule
//
//  Created by 贾晓滨 on 2020/1/2.
//

#import "RKLog.h"
#import "RKFileManager.h"
#import <CocoaLumberjack/DDASLLogger.h>

@implementation RKLog

+ (void)setupLogerStatus
{
#ifdef DEBUG
    //set color on
    setenv("XcodeColors", "YES", 0);
    
    //This class provides a logger for Terminal output or Xcode console output
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    //This class provides a logger for the Apple System Log facility
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    
//在硬盘上存储接口数据和tracker
    NSString *logPath = [[RKFileManager appCachePath] stringByAppendingString:@"/Logs"];
    if ([RKFileManager isFileExsit:logPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:logPath error:nil];
    }
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 0;
    fileLogger.maximumFileSize = 0;
    [DDLog addLogger:fileLogger withLevel:LOG_FLAG_DATA_TO_FILE];
    
    // And then enable colors
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor lightGrayColor] backgroundColor:nil forFlag:DDLogFlagVerbose];
    
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor cyanColor] backgroundColor:nil forFlag:DDLogFlagDebug];
    
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor magentaColor] backgroundColor:nil forFlag:DDLogFlagInfo];
    
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor brownColor] backgroundColor:nil forFlag:DDLogFlagWarning];
    
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor redColor] backgroundColor:nil forFlag:DDLogFlagError];
#endif
}

+ (NSArray *)getLogPath
{
    NSString *libPath = [RKFileManager appLibPath];
    
    NSString *logPath = [libPath stringByAppendingPathComponent:@"Caches"];
    logPath = [logPath stringByAppendingPathComponent:@"Logs"];
    
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *fileList = [fileManger contentsOfDirectoryAtPath:logPath error:&error];
    NSMutableArray * listArray = [NSMutableArray array];
    for (NSString * oneLogPath in fileList)
    {
        if([oneLogPath hasSuffix:@".log"])
        {
            NSString *truePath = [logPath stringByAppendingPathComponent:oneLogPath];
            [listArray addObject:truePath];
        }
    }
    return listArray;
}

@end
