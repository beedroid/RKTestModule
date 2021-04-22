//
//  UILabel+NumberIncrement.m
//  OneStoreFramework
//
//  Created by HUI on 15/8/13.
//  Copyright (c) 2015年 OneStore. All rights reserved.
//

#import "UILabel+NumberIncrement.h"
#import "NSNumber+Format.h"

#define kStartNumber @"startNumber"
#define kEndNumber @"endNumber"
#define kTimes @"times"
#define kDelayBetweenTimes @"delayBetweenTimes"
#define kIsInt @"isInt"

static CGFloat duration;

@implementation UILabel (NumberIncrement)

- (void)setLabelStartNumber:(NSNumber *)startNumber endNumber:(NSNumber *)endNumber times:(NSInteger)times delayBetweenTimes:(CGFloat)seconds isInt:(BOOL)isInt {
    if (!startNumber || !endNumber || !times || !seconds) {
        return;
    }
    duration = times * seconds;
    if (isInt) {
        self.text = [NSString stringWithFormat:@"%zd", startNumber.integerValue];
    } else {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[startNumber moneyFormatString]];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
        self.attributedText =str;
    }
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(timerAction:) userInfo:@{kStartNumber:startNumber, kEndNumber:endNumber, kTimes:@(times), kDelayBetweenTimes:@(seconds), kIsInt:@(isInt)} repeats:YES];
    [timer fire];
}

- (void)timerAction:(NSTimer *)timer {
    
    CGFloat seconds = [timer.userInfo[kDelayBetweenTimes] floatValue];
    BOOL isInt = [timer.userInfo[kIsInt] boolValue];
    NSNumber *endNumber = timer.userInfo[kEndNumber];
    NSNumber *startNumber = timer.userInfo[kStartNumber];
    if (duration > 0) {
        duration -= seconds;
        CGFloat gap = duration/seconds;
        if (gap < 1) {
            gap = 1;
        }
        if (isInt) {
            NSInteger current = self.text.integerValue;
            current += (floor(([endNumber integerValue]-[startNumber integerValue])/gap));
            self.text = [NSString stringWithFormat:@"%zd", current];
        } else {
            double current = self.text.doubleValue;
            current += (([endNumber doubleValue]-[startNumber doubleValue])/gap);
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSNumber moneyFormat:current]];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
            self.attributedText =str;
        }
    }else
    {
        [timer invalidate];
        timer = nil;
        if (isInt) {
            self.text = [NSString stringWithFormat:@"%d", endNumber.integerValue];
        } else {
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[endNumber moneyFormatString]];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
            self.attributedText =str;
        }
        
    }
}

@end
