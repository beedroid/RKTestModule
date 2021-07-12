//
//  ChatTableViewCell.h
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/4.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ChatItemViewModule;

@interface ChatTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) ChatItemViewModule *model;

+ (CGFloat)fixedHeight;


@end

NS_ASSUME_NONNULL_END
