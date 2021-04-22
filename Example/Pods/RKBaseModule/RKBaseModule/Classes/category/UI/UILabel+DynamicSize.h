//
//  UILabel + DynamicSize.h
//  OneStore
//
//  Created by airspuer on 13-8-22.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UILabel(DynamicSize)
/**
 *	功能:根据内容动态适应高度
 */
- (void)resizeToFit;

/**
 *	功能:根据内容动态适应宽度
 */
- (void)resizeToStretch;
@end
