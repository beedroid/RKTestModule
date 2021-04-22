//
//  UIButton+MyYhdUtil.h
//  MyyhdProject
//
//  Created by Eason Qian on 14-9-24.
//
//

#import <UIKit/UIKit.h>

@interface UIButton (MyYhdUtil)

+ (UIButton *)adButtonWithinController:(UIViewController *)viewController withSelector:(SEL)selector;

+ (UIButton *)saveButtonWithinController:(UIViewController *)viewController withSelector:(SEL)selector;

+ (UIButton *)grayButtonWithinController:(UIViewController *)viewController andTitle:(NSString *)title withSelector:(SEL)selector;

@end
