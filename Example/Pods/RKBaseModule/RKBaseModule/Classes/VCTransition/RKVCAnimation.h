//
//  OTSVCAnimation.h
//  RKBaseModule
//
//  Created by 贾晓滨 on 2020/1/2.
//

#import <Foundation/Foundation.h>

@interface RKVCAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, readonly, getter=isPush) BOOL push;

+ (instancetype)animationWithType:(BOOL)push;

@end
