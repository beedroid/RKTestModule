//
//  UIScrollView+SVInfiniteLoadingMore.h
//  OneStoreFramework
//
//  Created by yhd on 15/6/26.
//  Copyright (c) 2015年 OneStore. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <UIKit/UIKit.h>

@class SVInfiniteLoadingMoreView;

@interface UIScrollView (SVInfiniteLoadingMore)

- (void)addInfiniteScrollingWithActionHandler:(void (^)(void))actionHandler;
- (void)triggerInfiniteScrolling;

@property (nonatomic, strong, readonly) SVInfiniteLoadingMoreView *infiniteScrollingView;
@property (nonatomic, assign) BOOL showsInfiniteScrolling;

@end


enum {
    SVInfiniteLoadingMoreStateStopped = 0,
    SVInfiniteLoadingMoreStateTriggered,
    SVInfiniteLoadingMoreStateLoading,
    SVInfiniteLoadingMoreStateAll = 10
};

typedef NSUInteger SVInfiniteLoadingMoreState;

@interface SVInfiniteLoadingMoreView : UIView

@property (nonatomic, readwrite) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
@property (nonatomic, strong) UILabel *refreshLable;
@property (nonatomic, readonly) SVInfiniteLoadingMoreState state;
@property (nonatomic, readwrite) BOOL enabled;

- (void)setCustomView:(UIView *)view forState:(SVInfiniteLoadingMoreState)state;

- (void)startAnimating;
- (void)stopAnimating;

@end