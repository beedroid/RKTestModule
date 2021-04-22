//
//  RKVCAnimatedHandler.m
//  AFNetworking
//
//  Created by 贾晓滨 on 2020/1/21.
//

#import "RKVCAnimatedHandler.h"
#import "RKVCAnimation.h"

@implementation RKVCAnimatedHandler
- (nullable id <UIViewControllerAnimatedTransitioning>) navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return [[RKVCAnimation alloc] init];
}
@end
