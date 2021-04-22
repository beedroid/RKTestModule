//
//  RKLog.h
//  RKBaseModule
//
//  Created by 贾晓滨 on 2020/1/2.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/Cocoalumberjack.h>

//新增log level用作log日志
#define LOG_FLAG_DATA_TO_FILE     (1 << 5)  // 0...100000
#define DDLogDataToFile(frmt, ...) LOG_MAYBE(NO, LOG_LEVEL_DEF, LOG_FLAG_DATA_TO_FILE, 0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)

#ifdef DEBUG

static const int ddLogLevel = (DDLogLevelVerbose | LOG_FLAG_DATA_TO_FILE);
#define NSLog(...) NSLog(__VA_ARGS__)

#else

static const DDLogLevel ddLogLevel = DDLogLevelOff;
// Release下屏蔽NSLog
#define NSLog(...) {}
// Release下去掉断言
#define NS_BLOCK_ASSERTIONS

#endif

#define RKLogV(frmt, ...) DDLogVerbose(frmt, ##__VA_ARGS__)
#define RKLogD(frmt, ...) DDLogDebug(frmt, ##__VA_ARGS__)
#define RKLogI(frmt, ...) DDLogInfo(frmt, ##__VA_ARGS__)
#define RKLogW(frmt, ...) DDLogWarn(frmt, ##__VA_ARGS__)
#define RKLogE(frmt, ...) DDLogError(frmt, ##__VA_ARGS__)
#define RKLogF(frmt, ...) DDLogDataToFile(frmt, ##__VA_ARGS__)

//log
#define LOG_PRETTY_FUNCTION RKLogV(@"%s", __PRETTY_FUNCTION__)
#define LOG_LINE_PRETTY_FUNCTION RKLogV(@"line[%d] %s", __LINE__, __PRETTY_FUNCTION__)

//func log
#define RKLogFuncV RKLogV(@"[%@ call %@]", [self class], THIS_METHOD)
#define RKLogFuncD RKLogD(@"[%@ call %@]", [self class], THIS_METHOD)
#define RKLogFuncI RKLogI(@"[%@ call %@]", [self class], THIS_METHOD)
#define RKLogFuncW RKLogW(@"[%@ call %@]", [self class], THIS_METHOD)
#define RKLogFuncE RKLogE(@"[%@ call %@]", [self class], THIS_METHOD)

NS_ASSUME_NONNULL_BEGIN

@interface RKLog : NSObject
+ (void)setupLogerStatus;
@end

NS_ASSUME_NONNULL_END
