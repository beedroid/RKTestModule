//
//  RKResponseViewController.m
//  RKTestModule_Example
//
//  Created by 贾晓滨 on 2020/2/28.
//  Copyright © 2020 beedroid. All rights reserved.
//

#import "RKResponseViewController.h"
#import <UIKit/UIKit.h>

@interface RKResponseTestView : UILabel
@property (nonatomic, copy) NSString *name;
@end

@interface RKResponseViewController ()

@end

@implementation RKResponseTestView
- (id) initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

// recursively calls -pointInside:withEvent:. point is in the receiver's coordinate system
- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event {
    NSLog(@"Label-HitTest:%@", self.name);
    UIView * ret = [super hitTest:point withEvent:event];
    return ret;
}
// default returns YES if point is in bounds
- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {
    NSLog(@"Label-PointInside:%@", self.name);
    BOOL isIn = [super pointInside:point withEvent:event];
    return isIn;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"name"]) {
        self.text = self.name;
    }
}
- (void)dealloc {
    [self removeObserver:self forKeyPath:@"name" context:nil];
}
@end

@implementation RKResponseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"响应链";
    RKResponseTestView *viewA = [[RKResponseTestView alloc] initWithFrame:CGRectMake(0, 88, 300, 200)];
    
    RKResponseTestView *viewA1 = [[RKResponseTestView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [viewA addSubview:viewA1];
    RKResponseTestView *viewA2 = [[RKResponseTestView alloc] initWithFrame:CGRectMake(200, 0, 100, 100)];
    [viewA addSubview:viewA2];
    [self.view addSubview:viewA];
    
    RKResponseTestView *viewB = [[RKResponseTestView alloc] initWithFrame:CGRectMake(0, 188, 300, 200)];
    RKResponseTestView *viewB1 = [[RKResponseTestView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [viewB addSubview:viewB1];
    RKResponseTestView *viewB2 = [[RKResponseTestView alloc] initWithFrame:CGRectMake(200, 0, 100, 100)];
    [viewB addSubview:viewB2];
    [self.view addSubview:viewB];
    
    RKResponseTestView *viewC = [[RKResponseTestView alloc] initWithFrame:CGRectMake(0, 188+200, 300, 200)];
    [self.view addSubview:viewC];
    
    viewA.name = @"viewA";
    viewA1.name = @"viewA1";
    viewA2.name = @"viewA2";
    
    viewB.name = @"viewB";
    viewB1.name = @"viewB1";
    viewB2.name = @"viewB2";
    
    viewC.name = @"viewC";
}

@end
