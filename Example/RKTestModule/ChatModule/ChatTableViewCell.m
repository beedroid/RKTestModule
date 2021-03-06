//
//  ChatTableViewCell.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/4.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "ChatTableViewCell.h"
#import "UIView+SDAutoLayout.h"
#import "ChatItemViewModule.h"

#define kDeleteButtonWidth      60.0f
#define kTagButtonWidth         100.0f
#define kCriticalTranslationX   30
#define kShouldSlideX           -2

@interface ChatTableViewCell ()

@property (nonatomic, assign) BOOL isSlided;

@end

@implementation ChatTableViewCell
{
    UIButton *_deleteButton;
    UIButton *_tagButton;
    
    UIPanGestureRecognizer *_pan;
    UITapGestureRecognizer *_tap;
    
    BOOL _shouldSlide;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
        [self setupGestureRecognizer];
    }
    return self;
}

#pragma mark - private actions

- (void)setupView
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _iconImageView = [UIImageView new];
    _iconImageView.layer.cornerRadius = 5;
    _iconImageView.clipsToBounds = YES;
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:16];
    _nameLabel.textColor = [UIColor blackColor];
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor lightGrayColor];
    
    _messageLabel = [UILabel new];
    _messageLabel.font = [UIFont systemFontOfSize:14];
    _messageLabel.textColor = [UIColor lightGrayColor];
    
    _deleteButton = [UIButton new];
    _deleteButton.backgroundColor = [UIColor redColor];
    [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    
    _tagButton = [UIButton new];
    _tagButton.backgroundColor =[UIColor lightGrayColor];
    [_tagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_tagButton setTitle:@"标记未读" forState:UIControlStateNormal];
    
    [self.contentView addSubview:_iconImageView];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:_messageLabel];
    [self insertSubview:_deleteButton belowSubview:self.contentView];
    [self insertSubview:_tagButton belowSubview:self.contentView];
    
    _deleteButton.sd_layout
    .topEqualToView(self)
    .rightEqualToView(self)
    .bottomEqualToView(self)
    .widthIs(kDeleteButtonWidth);
    
    _tagButton.sd_layout
    .topEqualToView(_deleteButton)
    .bottomEqualToView(_deleteButton)
    .rightSpaceToView(_deleteButton, 0)
    .widthIs(kTagButtonWidth);
    
    UIView *superView = self.contentView;
    CGFloat margin = 10;
    
    _iconImageView.sd_layout
    .widthIs(50)
    .heightEqualToWidth()
    .leftSpaceToView(superView, margin)
    .topSpaceToView(superView, margin);
    
    _nameLabel.sd_layout
    .topEqualToView(_iconImageView)
    .leftSpaceToView(_iconImageView, margin)
    .rightSpaceToView(superView, 80)
    .heightIs(26);
    
    _timeLabel.sd_layout
    .rightSpaceToView(superView, margin)
    .centerYEqualToView(_nameLabel)
    .heightIs(16);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:60];
    
    _messageLabel.sd_layout
    .leftEqualToView(_nameLabel)
    .bottomSpaceToView(superView, margin * 1.3)
    .heightIs(18)
    .rightSpaceToView(superView, margin);
}

- (void)setupGestureRecognizer
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    _pan = pan;
    pan.delegate = self;
    pan.delaysTouchesBegan = YES;
    [self.contentView addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    tap.delegate = self;
    tap.enabled = NO;
    [self.contentView addGestureRecognizer:tap];
    _tap = tap;
}

- (void)tapView:(UITapGestureRecognizer *)tap
{
    if (self.isSlided) {
        [self cellSlideAnimationWithX:0];
    }
}

- (void)panView:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:pan.view];
    
    if (self.contentView.left <= kShouldSlideX) {
        _shouldSlide = YES;
    }

    if (fabs(point.y) < 1.0) {
        if (_shouldSlide) {
            [self slideWithTranslation:point.x];
        } else if (fabs(point.x) >= 1.0) {
            [self slideWithTranslation:point.x];
        }
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGFloat x = 0;
        if (self.contentView.left < -kCriticalTranslationX && !self.isSlided) {
            x = -(kDeleteButtonWidth + kTagButtonWidth);
        }
        [self cellSlideAnimationWithX:x];
        _shouldSlide = NO;
    }
    
    [pan setTranslation:CGPointZero inView:pan.view];
}


- (void)cellSlideAnimationWithX:(CGFloat)x
{
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:2 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.contentView.left = x;
    } completion:^(BOOL finished) {
        self.isSlided = (x != 0);
    }];
}

- (void)slideWithTranslation:(CGFloat)value
{
    if (self.contentView.left < -(kDeleteButtonWidth + kTagButtonWidth) * 1.1 || self.contentView.left > 30) {
        value = 0;
    }
    self.contentView.left += value;
}

#pragma mark - properties

- (void)setModel:(ChatItemViewModule *)model
{
    _model = model;
    
    self.iconImageView.image = [UIImage imageNamed:model.imageName];
    self.nameLabel.text = model.name;
    self.timeLabel.text = model.time;
    self.messageLabel.text = model.message;
}

- (void)setIsSlided:(BOOL)isSlided
{
    _isSlided = isSlided;
    
    _tap.enabled = isSlided;
}

#pragma mark - public actions

+ (CGFloat)fixedHeight
{
    return 70;
}

#pragma mark - gestureRecognizer delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (self.contentView.left <= kShouldSlideX && otherGestureRecognizer != _pan && otherGestureRecognizer != _tap) {
        return NO;
    }
    return YES;
}

@end
