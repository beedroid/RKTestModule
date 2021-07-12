//
//  RKRunloopHelper.m
//  RKTestModule_Example
//
//  Created by 贾晓滨 on 2021/6/11.
//  Copyright © 2021 beedroid. All rights reserved.
//

#import "RKRunloopHelper.h"

@implementation RKRunloopHelper

#pragma mark - 单例实现
static RKRunloopHelper *_sharedInstance;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}


+ (void)load {
//    [[RKRunloopHelper sharedInstance] addObserver];
}
// 添加一个监听者
- (void)addObserver {
     
     // 1. 创建监听者
     /**
      *  创建监听者
      *
      *  @param allocator#>  分配存储空间
      *  @param activities#> 要监听的状态
      *  @param repeats#>    是否持续监听
      *  @param order#>      优先级, 默认为0
      *  @param observer     观察者
      *  @param activity     监听回调的当前状态
      */
     CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
         /*
          kCFRunLoopEntry = (1UL << 0),          进入工作
          kCFRunLoopBeforeTimers = (1UL << 1),   即将处理Timers事件
          kCFRunLoopBeforeSources = (1UL << 2),  即将处理Source事件
          kCFRunLoopBeforeWaiting = (1UL << 5),  即将休眠
          kCFRunLoopAfterWaiting = (1UL << 6),   被唤醒
          kCFRunLoopExit = (1UL << 7),           退出RunLoop
          kCFRunLoopAllActivities = 0x0FFFFFFFU  监听所有事件
          */
         switch (activity) {
             case kCFRunLoopEntry:
                 NSLog(@"进入");
                 break;
             case kCFRunLoopBeforeTimers:
                 NSLog(@"即将处理Timer事件");
                 break;
             case kCFRunLoopBeforeSources:
                 NSLog(@"即将处理Source事件");
                 break;
             case kCFRunLoopBeforeWaiting:
                 // CA框架注册了_beforeCACommitHandler和_afterCACommitHandler两个监听方法
                 // _UIGestureRecognizerUpdateObserver()监听也在beforewaiting
                 NSLog(@"即将休眠");
                 break;
             case kCFRunLoopAfterWaiting:
                 NSLog(@"被唤醒");
                 break;
             case kCFRunLoopExit:
                 NSLog(@"退出RunLoop");
                 break;
             default:
                 break;
         }
     });
     
     // 2. 添加监听者
     /**
      *  给指定的RunLoop添加监听者
      *
      *  @param rl#>       要添加监听者的RunLoop
      *  @param observer#> 监听者对象
      *  @param mode#>     RunLoop的运行模式, 填写默认模式即可
      */
     CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
 }
@end
