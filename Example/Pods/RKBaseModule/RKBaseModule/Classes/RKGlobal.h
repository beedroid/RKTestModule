//
//  RKGlobal.h
//  RKBaseModule
//
//  Created by 贾晓滨 on 2020/1/2.
//

#ifndef RKGlobal_h
#define RKGlobal_h

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 \
alpha:1.0]

//special color
#define RKCOLOR_ORANGE [UIColor colorWithRed:223.0/255 green:119.0/255 blue:28.0/255 alpha:1]
#define RKCOLOR_TEXT [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1]
#define RKCOLOR_RED [UIColor colorWithRed:220.0/255 green:0/255 blue:0/255 alpha:1]
#define RKCOLOR_BLUE [UIColor colorWithRed:104.0/255 green:144.0/255 blue:223.0/255 alpha:1]
#define RKCLOLR_DISABLE [UIColor colorWithRed:169.0/255 green:169.0/255 blue:169.0/255 alpha:1.0]
#define RKCLOLR_GRAY(degree) [UIColor colorWithRed:degree/255.0 green:degree/255.0 blue:degree/255.0 alpha:1.0]

//weak strong self for retain cycle
#define WEAK_SELF __weak typeof(self)weakSelf = self
#define STRONG_SELF __strong typeof(weakSelf)self = weakSelf

// 单例
#undef    AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef    DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once(&once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

//判断ios版本
#define IOS_SDK_MORE_THAN_OR_EQUAL(__num) [UIDevice currentDevice].systemVersion.floatValue >= (__num)
#define IOS_SDK_MORE_THAN(__num) [UIDevice currentDevice].systemVersion.floatValue > (__num)
#define IOS_SDK_LESS_THAN(__num) [UIDevice currentDevice].systemVersion.floatValue < (__num)

//判断设备
#define IS_IPAD_DEVICE UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define IS_IPHONE_DEVICE UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone

#define ISIPHONE3_5  CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size)
#define ISIPHONE4_0  CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size)
#define ISIPHONE4_7  CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size)
#define ISIPHONE5_5  CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size)
#define ISIPHONE9_7  CGSizeEqualToSize(CGSizeMake(768, 1024), [[UIScreen mainScreen] bounds].size)
#define ISIPHONE9_7_LAND  CGSizeEqualToSize(CGSizeMake(1024, 768), [[UIScreen mainScreen] bounds].size)

//判断横竖屏
#define IS_LANDSCAPE UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)

//获取当前屏幕尺寸
#define SCREEN_SIZE (((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))?CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width):[UIScreen mainScreen].bounds.size)

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// 本地化
#define RKSTRING(_str)  NSLocalizedString((_str),(_str))

//pad横竖屏比率
#define UI_PAD_LAND_RATIO (IS_LANDSCAPE?(1024.0/768):1)

#define RKNotify_CDN_LOG @"RK_CDN_LOG"

#endif /* RKGlobal_h */
