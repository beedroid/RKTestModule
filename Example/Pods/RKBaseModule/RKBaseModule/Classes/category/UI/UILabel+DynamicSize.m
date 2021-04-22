//
//  UILabel + DynamicSize.m
//  OneStore
//
//  Created by airspuer on 13-8-22.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import "UILabel+DynamicSize.h"
#import "UIView+Extension.h"

@implementation UILabel(DynamicSize)

- (void)resizeToFit
{
    float height = [self expectedHeight];
    CGRect newFrame = [self frame];
    newFrame.size.height = height;
    [self setFrame:newFrame];
}

- (float)expectedHeight
{
    [self setNumberOfLines:0];
    [self setLineBreakMode:NSLineBreakByWordWrapping];
    float width = self.frame.size.width;
    if(-0.0001 < width && width < 0.0001){
        CGSize size = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
        width = size.width;
		self.width = width;
    }
    
    CGSize maximumLabelSize = CGSizeMake(width ,9999);
    
    CGSize expectedLabelSize = [[self text] boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[self font]} context:nil].size;
    return expectedLabelSize.height;
}

- (void)resizeToStretch
{
    float width = [self expectedWidth];
    CGRect newFrame = [self frame];
    newFrame.size.width = width;
    [self setFrame:newFrame];
}

- (float)expectedWidth
{
    [self setNumberOfLines:1];
    float height = self.frame.size.height;
    if(-0.0001 < height && height < 0.0001){
        height = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}].height;
		self.height = height;
    }
    CGSize maximumLabelSize = CGSizeMake(9999, height);
    
    CGSize expectedLabelSize = [[self text] boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[self font]} context:nil].size;
    return expectedLabelSize.width + 20.f;
}
@end
