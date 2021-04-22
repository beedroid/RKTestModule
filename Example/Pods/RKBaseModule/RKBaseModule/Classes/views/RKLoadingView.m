//
//  RKLoadingView.m
//  RKBaseModule
//
//  Created by 贾晓滨 on 2020/1/2.
//

#import "RKLoadingView.h"


@implementation RKLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        [self.layer setCornerRadius:10.0];

        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [activity startAnimating];
        [self addSubview:activity];
        
        activity.frame = CGRectMake(self.bounds.size.width / 2.0f - 40.0f,
                                    self.bounds.size.height / 2.0f - 40.0f,
                                    80.0f,
                                    80.0f);

    }
    return self;
}

+ (instancetype)showLoadingAddedTo:(UIView *)view animated:(BOOL)animated
{
    RKLoadingView *loadingView = [[self alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    loadingView.frame = CGRectMake(view.bounds.size.width / 2.0f - 40.0f,
                                   view.bounds.size.height / 2.0f - 40.0f,
                                   80.0f,
                                   80.0f);
    [view addSubview:loadingView];
    
    loadingView.alpha = 0.f;
    if (animated) {
        [UIView animateWithDuration:.3f animations:^{
            loadingView.alpha = 1.f;
        }];
    }
    else {
        loadingView.alpha = 1.0;
    }
    return loadingView;
}

+ (void)hideLoadingForView:(UIView *)view animated:(BOOL)animated
{
    NSMutableArray *viewsToRemove = [NSMutableArray array];

    for (UIView *v in [view subviews]) {
        if ([v isKindOfClass:[RKLoadingView class]]) {
            [viewsToRemove addObject:v];
        }
    }

    for (RKLoadingView *loadingView in viewsToRemove){
        if (animated) {
            
            [UIView animateWithDuration:.3f animations:^{
                loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                [loadingView removeFromSuperview];
            }];
        }
        else {
            loadingView.alpha = 0.0;
            [loadingView removeFromSuperview];
        }

    }
}

@end
