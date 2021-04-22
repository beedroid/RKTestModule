//
//  UILabel+NumberIncrement.h
//  OneStoreFramework
//
//  Created by HUI on 15/8/13.
//  Copyright (c) 2015年 OneStore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (NumberIncrement)

- (void)setLabelStartNumber:(NSNumber *)startNumber endNumber:(NSNumber *)endNumber times:(NSInteger)times delayBetweenTimes:(CGFloat)seconds isInt:(BOOL)isInt;

@end
