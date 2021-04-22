//
//  UICollectionView+LoadingMore.m
//  OneStoreFramework
//
//  Created by Eason Qian on 15/6/23.
//  Copyright (c) 2015年 OneStore. All rights reserved.
//

#import "UICollectionView+LoadingMore.h"
#import "NSObject+Associated.h"

@implementation UICollectionView (LoadingMore)

-(void)setIsLoadingNow:(NSNumber *)isLoadingNow{
    [self objc_setAssociatedObject:@"isLoadingNow" value:isLoadingNow policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
}

-(NSNumber *)isLoadingNow{
    return [self objc_getAssociatedObject:@"isLoadingNow"];
}

-(void)setFooterView:(UIView *)footerView{
    [self objc_setAssociatedObject:@"footerView" value:footerView policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
}

-(UIView *)footerView{
    return [self objc_getAssociatedObject:@"footerView"];
}

- (void)showLoadingMore {
    [self showLoadingMoreWithHeight:40.f andEdgeInsets:UIEdgeInsetsZero];
}

- (void)showLoadingMoreWithHeight:(CGFloat)aHeight andEdgeInsets:(UIEdgeInsets)aInsets {
    self.isLoadingNow = @(YES);
    CGFloat width = self.frame.size.width;
    CGFloat height = aHeight;
    
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentSize.height, width, height)];
    self.contentInset = UIEdgeInsetsMake(0, 0, aHeight, 0);
    self.contentSize = CGSizeMake(width, self.contentSize.height);
    self.footerView.tag = 1000;
    
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
    [indicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [indicatorView startAnimating];
    [self.footerView addSubview:indicatorView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.tag = 999;
    [label setBackgroundColor:[UIColor clearColor]];
    [label setText:@"正在加载"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [label setFont:[UIFont systemFontOfSize:15.0]];
    [self.footerView addSubview:label];
    
    [self addSubview:self.footerView];
    
    [self.footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[indicatorView][label]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(indicatorView, label)]];
    
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:indicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeCenterY multiplier:1.f constant:aInsets.top - aInsets.bottom]];
    
    [self.footerView addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.footerView attribute:NSLayoutAttributeCenterX multiplier:1.f constant:aInsets.left - aInsets.right]];
}

- (void)stopLoadingMoreWithIsHaveData:(BOOL )isHaveData{
    
    [self.footerView removeFromSuperview];
    self.footerView = nil;
    self.isLoadingNow = @(NO);
    if (!isHaveData) {
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

- (void)stopLoadingMore {
    for (UIView *subView in self.subviews) {
        if (subView.tag == 1000) {
            [subView removeFromSuperview];
            self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            self.isLoadingNow = @(NO);
            break;
        }
    }
}

- (BOOL)isLoading {
    return self.isLoadingNow.boolValue;
}

@end
