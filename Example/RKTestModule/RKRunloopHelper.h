//
//  RKRunloopHelper.h
//  RKTestModule_Example
//
//  Created by 贾晓滨 on 2021/6/11.
//  Copyright © 2021 beedroid. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RKRunloopHelper : NSObject
+ (instancetype)sharedInstance;
- (void)addObserver;
@end

NS_ASSUME_NONNULL_END
