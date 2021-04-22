//
//  RKLoadingView.h
//  RKBaseModule
//
//  Created by 贾晓滨 on 2020/1/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RKLoadingView : UIView
+ (instancetype)showLoadingAddedTo:(UIView *)view animated:(BOOL)animated;
+ (void)hideLoadingForView:(UIView *)view animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
