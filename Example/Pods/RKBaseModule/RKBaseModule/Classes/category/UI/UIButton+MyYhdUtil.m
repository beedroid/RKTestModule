//
//  UIButton+MyYhdUtil.m
//  MyyhdProject
//
//  Created by Eason Qian on 14-9-24.
//
//

#import "UIButton+MyYhdUtil.h"
#import "RKGlobal.h"

@implementation UIButton (MyYhdUtil)

+ (UIButton *)adButtonWithinController:(UIViewController *)viewController withSelector:(SEL)selector
{
    UIButton *_addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = CGRectMake(0.0, 0.0, 30.0, 31.0);
    [_addButton setTitle:@"" forState:UIControlStateNormal];
    [_addButton setImage:[UIImage imageNamed:@"address_add"] forState:UIControlStateNormal];
    [_addButton setImage:[UIImage imageNamed:@"address_add_active"] forState:UIControlStateHighlighted];
    [_addButton addTarget:viewController action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return _addButton;
}

+ (UIButton *)saveButtonWithinController:(UIViewController *)viewController withSelector:(SEL)selector
{
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(0.0, 0.0, 44.0, 31.0);
    [_backButton setBackgroundImage:[[UIImage imageNamed:@"title_red_btn"] stretchableImageWithLeftCapWidth:12 topCapHeight:6] forState:UIControlStateNormal];
    [_backButton setBackgroundImage:[[UIImage imageNamed:@"title_red_btn_sel"] stretchableImageWithLeftCapWidth:12 topCapHeight:6] forState:UIControlStateHighlighted];
    [_backButton setTitle:@"保存" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_backButton addTarget:viewController action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return _backButton;
}

+ (UIButton *)grayButtonWithinController:(UIViewController *)viewController andTitle:(NSString *)title withSelector:(SEL)selector
{
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(0.0, 0.0, 44.0, 31.0);
    [_backButton setBackgroundImage:[[UIImage imageNamed:@"grzx_btn_normal"] stretchableImageWithLeftCapWidth:12 topCapHeight:6] forState:UIControlStateNormal];
    [_backButton setBackgroundImage:[[UIImage imageNamed:@"grzx_btn_pressed"] stretchableImageWithLeftCapWidth:12 topCapHeight:6] forState:UIControlStateHighlighted];
    [_backButton setTitle:title forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_backButton setTitleColor:RGB(155, 130, 125) forState:UIControlStateNormal];
    [_backButton addTarget:viewController action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return _backButton;
}

@end
