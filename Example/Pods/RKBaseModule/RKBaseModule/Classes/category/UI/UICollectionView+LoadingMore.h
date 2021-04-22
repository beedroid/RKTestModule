//
//  UICollectionView+LoadingMore.h
//  OneStoreFramework
//
//  Created by Eason Qian on 15/6/23.
//  Copyright (c) 2015年 OneStore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (LoadingMore)

@property (nonatomic, strong) NSNumber *isLoadingNow;

@property (nonatomic, strong) UIView *footerView;

- (void)showLoadingMore;
/*
 * 此方法是为了解决加载结束后 collectionView 会向下偏移的问题
 */
- (void)stopLoadingMoreWithIsHaveData:(BOOL)isHaveData;

- (void)stopLoadingMore;

- (BOOL)isLoading;

@end
