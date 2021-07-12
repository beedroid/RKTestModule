//
//  ChatItemViewModule.h
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/4.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatItemViewModule : NSObject
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *message;
@end

NS_ASSUME_NONNULL_END
