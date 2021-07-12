//
//  RKCALayerViewController.m
//  RKTestModule_Example
//
//  Created by 贾晓滨 on 2020/2/20.
//  Copyright © 2020 beedroid. All rights reserved.
//

#import "RKCALayerViewController.h"
#import <RKBaseModule/RKGlobalValue.h>
#define radians(degrees) (degrees * M_PI/180)


@interface RKLeftEyeView : UIView

@end

@implementation RKLeftEyeView

// setNeedsLayout 标记视图，使得runloop的下一个周期调用layoutSubviews
// layoutIfNeeded 如果这个视图有被setNeedsLayout方法标记的，那么会立即执行layoutSubviews方法。
// setNeedsDisplay 调用这个方法会执行drawRect方法。

- (void)layoutSubviews{
    /* layoutSubviews方法被调用的情况：
    a.直接调用setNeedsLayout方法时(注：已增加到父视图上).
    b.被增加到父视图上时addSubview(注：size不能为0) .
    c.给当前视图增加addSubview子视图时无论子视图的size是否为0，layoutSubviews都会被调用
    d.view的size发生改变的时候.
    e.滑动UIScrollView时.
    f.旋转Screen时会触发父控件上的layoutSubviews事件.
    */
    NSLog(@"layoutSubviews");
}
- (void)drawRect:(CGRect)rect{
    // UIView的绘制和渲染是两个过程，当UIView被绘制时，CPU执行drawRect，通过context将数据写入backing store。
    // drawRect是个补充和追加，不是覆盖
    /* drawRect方法被调用的情况：
     a.直接调用setNeedsDisplay或者setNeedsDisplayInRect:方法时.
     b.初始化时设置了视图大小时.
     c.调用过sizeToFit方法后.
     d.通过设置contentMode属性值为UIViewContentModeRedraw。那么将在每次设置或更改frame的时.
     */
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIImage *myImage = [UIImage imageNamed:@"search_price_keep"];
    CGRect myRect = CGRectMake(0, 0, myImage.size.width, myImage.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0, -(myRect.size.height-(myRect.size.height-2*myRect.origin.y-myRect.size.height)));//向上平移
    CGContextTranslateCTM (context, myRect.size.width/4, 0);
    CGContextScaleCTM (context, .25,  .5);
    CGContextRotateCTM (context, radians( 22.));
    CGContextDrawImage(context, myRect, myImage.CGImage);
}

@end


@interface RKCALayerViewController ()

@property (nonatomic, strong) RKLeftEyeView *leftEye;

@end

@implementation RKCALayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Runloop&渲染流程";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 左眼RKLeftEyeView通过drawRect方法追加了绘制内容
    self.leftEye = [[RKLeftEyeView alloc] initWithFrame:CGRectMake(130, 130, 50, 50)];
    UIImage *leftEyeImage = [UIImage imageNamed:@"leye"];
    self.leftEye.layer.contents = (__bridge id)leftEyeImage.CGImage;
    [self.leftEye setNeedsDisplay];
    [self.view addSubview:self.leftEye];

    // 右眼直接使用图片生成寄宿图
    UIView *rightEye = [[UIView alloc] init];
    rightEye.frame = CGRectMake(SCREEN_WIDTH-30-130, 130, 50, 50);
    UIImage *rightEyeImage = [UIImage imageNamed:@"eye"];
    rightEye.layer.contents = (__bridge id)rightEyeImage.CGImage;
    [self.view addSubview:rightEye];
    
    UIView *nose = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-15, 250, 50, 50)];
    nose.backgroundColor = [UIColor grayColor];
    [self.view addSubview:nose];
    
    [self addOperationButton];
}

- (void)addOperationButton{
    CGFloat gap = 10;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(gap, SCREEN_HEIGHT-150, 50, 30);
    [button setTitle:@"空操作" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(voidOperation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame = CGRectMake(gap*2+50*1, SCREEN_HEIGHT-150, 100, 30);
    [button2 setTitle:@"左眼脏标记" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(leftEyeNeedLayout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button3.frame = CGRectMake(gap*3+100*2, SCREEN_HEIGHT-150, 100, 30);
    [button3 setTitle:@"左眼立即布局" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(leftEyeLayoutNow) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button4.frame = CGRectMake(gap, SCREEN_HEIGHT-120, 100, 30);
    [button4 setTitle:@"左眼Display脏标记" forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(leftEyeNeedDisplay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
}

- (void)voidOperation{
    NSLog(@"空操作");
}

- (void)leftEyeNeedLayout{
    NSLog(@"给左眼打Layout脏标记操作");
    [self.leftEye setNeedsLayout];
}

- (void)leftEyeLayoutNow{
    NSLog(@"左眼立即Layout");
    [self.leftEye setNeedsLayout];
    [self.leftEye layoutIfNeeded];
}

- (void)leftEyeNeedDisplay{
    NSLog(@"给左眼打Display脏标记操作");
    [self.leftEye setNeedsDisplay];
}


@end

