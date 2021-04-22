//
//  UIViewController+custom.m
//  OneStoreFramework
//
//  Created by Aimy on 14-7-30.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "UIViewController+custom.h"

static const CGFloat OTSUpdownLayoutNaviBtnImgWidth = 24.0;
static const CGFloat OTSUpdownLayoutNaviBtnTitleHeight = 14.0;

@implementation OTSDataNaviBtn

@end

@implementation OTSUpdownLayoutNaviBtn
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.size.width/2-OTSUpdownLayoutNaviBtnImgWidth/2, contentRect.size.height/2-(OTSUpdownLayoutNaviBtnImgWidth+OTSUpdownLayoutNaviBtnTitleHeight)/2, OTSUpdownLayoutNaviBtnImgWidth, OTSUpdownLayoutNaviBtnImgWidth);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.height/2-(OTSUpdownLayoutNaviBtnImgWidth+OTSUpdownLayoutNaviBtnTitleHeight)/2+OTSUpdownLayoutNaviBtnImgWidth, contentRect.size.width, OTSUpdownLayoutNaviBtnTitleHeight);
}

@end

@implementation UIViewController (custom)



#pragma mark - navi button
/**
 *  功能:设置左按钮的类型（图片）
 *
 *  @param aType  按钮类型
 *  @param aFrame 图片大小(理论上只需要设置size就行)
 */
- (void)setNaviButtonType:(NaviButtonType)aType
                    frame:(CGRect)aFrame
{
    [self setNaviButtonType:aType isBgImg:NO frame:aFrame text:nil color:nil font:nil shadowOffset:CGSizeZero alignment:UIControlContentHorizontalAlignmentLeft edgeInsets:UIEdgeInsetsZero isLeft:YES];
}
/**
 *  功能:设置左按钮的类型（图片+文字）
 *  type:按钮类型  aFrame:大小  text:文字   color:颜色  font:样式
 */
- (void)setNaviButtonType:(NaviButtonType)aType
                    frame:(CGRect)aFrame
                     text:(NSString *)aText
                    color:(UIColor *)aColor
                     font:(UIFont *)aFont
{
    [self setNaviButtonType:aType isBgImg:NO frame:aFrame text:aText color:aColor font:aFont shadowOffset:CGSizeZero alignment:UIControlContentHorizontalAlignmentLeft edgeInsets:UIEdgeInsetsZero isLeft:YES];
}

- (void)setNaviButtonType:(NaviButtonType)aType
                  isBgImg:(BOOL)aIsBgImg
                    frame:(CGRect)aFrame
                     text:(NSString *)aText
                    color:(UIColor *)aColor
                     font:(UIFont *)aFont
             shadowOffset:(CGSize)aShadowOffset
                alignment:(UIControlContentHorizontalAlignment)aAlignment
               edgeInsets:(UIEdgeInsets)aEdgeInsets
                   isLeft:(BOOL)aLeft
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (CGRectEqualToRect(CGRectZero, aFrame)) {
        btn.frame = CGRectMake(0, 0, 24, 24);
    }
    else {
        btn.frame = aFrame;
    }
    
    SEL selector = nil;
    if (aLeft) {
        selector = @selector(leftBtnClicked:);
    }
    else {
        selector = @selector(rightBtnClicked:);
    }
    
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    //根据样式不同更改按钮图片
    UIImage *normalImage = nil;
    UIImage *highlightImage = nil;
    switch (aType) {
        case NaviButton_None: {//空的，无图片
            normalImage = nil;
            highlightImage = nil;
            break;
        }
        case NaviButton_Return: {//返回
            normalImage = [UIImage imageNamed:@"navigationbar_btn_return"];
            highlightImage = [UIImage imageNamed:@"navigationbar_btn_return_sel"];
            break;
        }
        default:
            normalImage = nil;
            highlightImage = nil;
            break;
    }
    
    if (aIsBgImg) {
        [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
        [btn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    } else {
        [btn setImage:normalImage forState:UIControlStateNormal];
        [btn setImage:highlightImage forState:UIControlStateHighlighted];
    }
    
    //按钮文字
    if (aText != nil) {
        [btn setTitle:aText forState:UIControlStateNormal];
    }
    
    if (aColor) {
        [btn setTitleColor:aColor forState:UIControlStateNormal];
    }
    
    if (aFont) {
        btn.titleLabel.font = aFont;
    }
    
    if (!CGSizeEqualToSize(CGSizeZero, aShadowOffset)) {
        btn.titleLabel.shadowOffset = aShadowOffset;
    }
    
    btn.contentHorizontalAlignment = aAlignment;
    
    if (!UIEdgeInsetsEqualToEdgeInsets(aEdgeInsets, UIEdgeInsetsZero)) {
        btn.contentEdgeInsets = aEdgeInsets;
    }
    
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    if (aLeft) {
        self.navigationItem.leftBarButtonItem = btnItem;
    }
    else {
        self.navigationItem.rightBarButtonItem = btnItem;
    }
}

- (void)setNaviButtonType:(NaviButtonType)aType
                    frame:(CGRect)aFrame
                     text:(NSString *)aText
                    color:(UIColor *)aColor
                     font:(UIFont *)aFont
             shadowOffset:(CGSize)aShadowOffset
                alignment:(UIControlContentHorizontalAlignment)aAlignment
               edgeInsets:(UIEdgeInsets)aEdgeInsets
                   isLeft:(BOOL)aLeft
{
    [self setNaviButtonType:aType isBgImg:NO frame:aFrame text:aText color:aColor font:aFont shadowOffset:aShadowOffset alignment:aAlignment edgeInsets:aEdgeInsets isLeft:aLeft];
}

- (void)setNaviButtonType:(NaviButtonType)aType isLeft:(BOOL)aLeft
{
    [self setNaviButtonType:aType frame:CGRectZero text:nil color:nil font:nil shadowOffset:CGSizeZero alignment:UIControlContentHorizontalAlignmentLeft edgeInsets:UIEdgeInsetsZero isLeft:aLeft];
}

- (void)setNaviButtonText:(NSString *)aText isLeft:(BOOL)aLeft
{
    [self setNaviButtonType:NaviButton_None frame:CGRectMake(0, 0, 40, 40) text:aText color:[UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1] font:[UIFont systemFontOfSize:14.0] shadowOffset:CGSizeZero alignment:UIControlContentHorizontalAlignmentCenter edgeInsets:UIEdgeInsetsZero isLeft:aLeft];
}

- (void)setUpdownLayoutNaviButtonType:(NaviButtonType)aType text:(NSString *)aText href:(NSString *)aHref items:(NSArray *)aItems isLeft:(BOOL)aLeft
{
    OTSDataNaviBtn *btn;
    if (aType!=NaviButton_None && aText.length>0) {
        btn = [OTSUpdownLayoutNaviBtn buttonWithType:UIButtonTypeCustom];
    } else {
        btn = [OTSDataNaviBtn buttonWithType:UIButtonTypeCustom];
    }
    btn.frame = CGRectMake(0, 0, 44, 44);
    btn.href = aHref;
    btn.items = aItems;
    
    SEL selector = nil;
    if (aLeft) {
        selector = @selector(leftBtnClicked:);
    }
    else {
        selector = @selector(rightBtnClicked:);
    }
    
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    //根据样式不同更改按钮图片
    UIImage *normalImage = nil;
    UIImage *highlightImage = nil;
    switch (aType) {
        case NaviButton_None: {//空的，无图片
            normalImage = nil;
            highlightImage = nil;
            break;
        }
        case NaviButton_Return: {//返回
            normalImage = [UIImage imageNamed:@"navigationbar_btn_return"];
            highlightImage = [UIImage imageNamed:@"navigationbar_btn_return_sel"];
            break;
        }
        default:
            normalImage = nil;
            highlightImage = nil;
            break;
    }
    
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:highlightImage forState:UIControlStateHighlighted];
    
    //按钮文字
    if (aText != nil) {
        [btn setTitle:aText forState:UIControlStateNormal];
    }
    
    //文字颜色
    [btn setTitleColor:[UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1] forState:UIControlStateNormal];
    
    //文字字体
    if (aType!=NaviButton_None && aText.length>0) {
        btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    } else {
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    }
    
    //文字居中
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    if (aLeft) {
        self.navigationItem.leftBarButtonItem = btnItem;
    }
    else {
        self.navigationItem.rightBarButtonItem = btnItem;
    }
}

- (void)leftBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnClicked:(id)sender
{
    
}

@end
