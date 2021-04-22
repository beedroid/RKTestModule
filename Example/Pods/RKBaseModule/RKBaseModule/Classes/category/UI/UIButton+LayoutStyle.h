//
//  UIButton+LayoutStyle.h
//  OneStore
//
//  Created by airspuer on 14-5-13.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RKUIButtonLayoutStyle) {
    RKDefalutStyle = 0,//默认的方式
	RKImageLeftTitleRightStyle = 1, // image左 title右
	RKTitleLeftImageRightStyle = 2, // image右,title左
	RKImageTopTitleBottomStyle = 3, //image上，title下
	RKTitleTopImageBottomStyle = 4, // image下,title上
};
@interface UIButton(LayoutStyle)

/**
 *  图片和文字显示方向
 */
@property(nonatomic)IBInspectable RKUIButtonLayoutStyle layoutStyle;

/**
 *  图片和文字之间的间距
 */
@property (nonatomic, assign) IBInspectable CGFloat layoutSpacing;

/**
 *	功能:设置UIButton的布局，图片和文字按照指定方向显示
 *
 *	@param aLayoutStyle:参见OTSUIButtonLayoutStyle
 *	@param aSpacing:图片和文字之间的间隔
 */
- (void)setLayout:(RKUIButtonLayoutStyle )aLayoutStyle
		  spacing:(CGFloat)aSpacing;
@end
