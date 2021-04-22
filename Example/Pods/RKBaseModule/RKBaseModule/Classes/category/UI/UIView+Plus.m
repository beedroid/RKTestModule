//
//  UIView+Plus.m
//  OneStore
//
//  Created by Yim Daniel on 13-1-28.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import "UIView+Plus.h"
#import "MBProgressHUD.h"
#import "NSMutableArray+safe.h"

@implementation UIView (Plus)

- (void)resignAllResonders
{
    for (UIView *sub in self.subviews)
    {
        [sub resignFirstResponder];
        [sub resignAllResonders];
    }
}

-(void)removeAllSubsWithClass:(Class)aClass
{
    for (UIView *sub in self.subviews)
    {
        if (aClass)
        {
            if ([sub isKindOfClass:aClass])
            {
                [sub removeFromSuperview];
            }
        }
        else
        {
            [sub removeFromSuperview];
        }
    }
}

- (NSArray *)subViewsWithClass:(Class)aClass
{
	NSMutableArray *subViewArray = [[NSMutableArray alloc] init];
	for (UIView *subview in self.subviews) {
		if ([subview isKindOfClass:aClass]) {
			[subViewArray safeAddObject:subview];
		}
	}
	if (subViewArray.count <= 0) {
		subViewArray = nil;
	}
	return subViewArray;
}

- (void)showLoadingWithMessage:(NSString *)aMessage
{
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.detailsLabelText = aMessage;
}

- (void)hideLoading
{
	[MBProgressHUD hideHUDForView:self animated:YES];
}

- (void)showToastWithTitle:(NSString *)title titleFont:(UIFont *)titleFont message:(NSString *)message messageFont:(UIFont *)messageFont duration:(CGFloat)duration {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    hud.labelFont = titleFont;
    hud.detailsLabelFont = messageFont;
    hud.detailsLabelText = message;
    [self addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:duration];
}
@end
