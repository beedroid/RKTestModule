//
//  RKAppDelegate.m
//  RKTestModule
//
//  Created by beedroid on 12/26/2019.
//  Copyright (c) 2019 beedroid. All rights reserved.
//

#import "RKAppDelegate.h"
#import "RKTabViewController.h"
#import "RKHomeViewController.h"
#import "RKCateViewController.h"
#import "RKCartViewController.h"
#import "RKAccountViewController.h"
#import <RKBaseModule/RKGlobal.h>
#import <QMUIKit/QMUIKit.h>
#import "QMUIConfigurationTemplate.h"
#import "QMUIConfigurationDarkTemplate.h"

NSString *const QDSelectedThemeIdentifier = @"selectedThemeIdentifier";
NSString *const QDThemeIdentifierDefault = @"Default";
NSString *const QDThemeIdentifierGrapefruit = @"Grapefruit";
NSString *const QDThemeIdentifierGrass = @"Grass";
NSString *const QDThemeIdentifierPinkRose = @"Pink Rose";
NSString *const QDThemeIdentifierDark = @"Dark";

@implementation RKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // 1. 先注册主题监听，在回调里将主题持久化存储，避免启动过程中主题发生变化时读取到错误的值
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThemeDidChangeNotification:) name:QMUIThemeDidChangeNotification object:nil];
    
    // 2. 然后设置主题的生成器
    QMUIThemeManagerCenter.defaultThemeManager.themeGenerator = ^__kindof NSObject * _Nonnull(NSString * _Nonnull identifier) {
        if ([identifier isEqualToString:@"Default"]) return QMUIConfigurationTemplate.new;
        if ([identifier isEqualToString:@"Dark"]) return QMUIConfigurationDarkTemplate.new;
        return nil;
    };
    
    // 3. 再针对 iOS 13 开启自动响应系统的 Dark Mode 切换
    // 如果不需要兼容 iOS 13 Dark Mode，则不需要这一段代码
    if (@available(iOS 13.0, *)) {
        // 先通过这个 block 来决定当系统的 Dark Mode 发生切换时，要如何映射到业务的主题
        QMUIThemeManagerCenter.defaultThemeManager.identifierForTrait = ^__kindof NSObject<NSCopying> * _Nonnull(UITraitCollection * _Nonnull trait) {
            if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return @"Dark";// 表示当检测到系统开启了 Dark Mode 时，将主题自动切换到 Dark
            }
            return @"Default";
        };
        
        // 然后让 QMUIThemeManager 自动响应系统的 Dark Mode 切换
        QMUIThemeManagerCenter.defaultThemeManager.respondsSystemStyleAutomatically = YES;
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self QMUIConfig];
    
    RKHomeViewController *homeVC = [[RKHomeViewController alloc] init];
    RKAccountViewController *accountVC = [[RKAccountViewController alloc] init];
    QMUINavigationController *homeNavigationController = [[QMUINavigationController alloc] initWithRootViewController:accountVC];
    homeNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页"
                                                                        image:UIImageMake(@"icon_tabbar_uikit")
                                                                          tag:100];
    
    RKCateViewController *cateVC = [[RKCateViewController alloc] init];
    QMUINavigationController *cateNavigationController = [[QMUINavigationController alloc] initWithRootViewController:cateVC];
    cateNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分类"
                                                                        image:UIImageMake(@"icon_tabbar_uikit")
                                                                          tag:101];
    
    RKCartViewController *cartVC = [[RKCartViewController alloc] initWithStyle:UITableViewStyleGrouped];
    QMUINavigationController *cartNavigationController = [[QMUINavigationController alloc] initWithRootViewController:cartVC];
    cartNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"购物车"
                                                                        image:UIImageMake(@"icon_tabbar_uikit")
                                                                          tag:102];
    
    
    QMUINavigationController *accountNavigationController = [[QMUINavigationController alloc] initWithRootViewController:homeVC];
    accountNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的"
                                                                           image:UIImageMake(@"icon_tabbar_uikit")
                                                                             tag:103];
    
    RKTabViewController *vc = [[RKTabViewController alloc] init];
    vc.viewControllers = @[homeNavigationController,
                           cateNavigationController,
                           cartNavigationController,
                           accountNavigationController];
    [self.window setRootViewController:vc];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    dispatch_group_t group = dispatch_group_create();
    // 获取全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, queue, ^{
        [self dosth];
    });
    dispatch_group_async(group, queue, ^{ [self dosth]; });
    dispatch_group_async(group, queue, ^{ [self dosth]; });
    // 当并发队列组中的任务执行完毕后才会执行这里的代码
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            // 合并图片
    });
    
    
    
    return YES;
}
static int vp=0;
- (void)dosth{
    while(vp<100){
        NSLog(@"%d --- %@", vp, [NSThread currentThread]);
        vp++;
    }
    
}

- (void)QMUIConfig{
#if DEBUG
    [QMUIConsole sharedInstance].canShow = YES;
#endif
}

- (void)handleThemeDidChangeNotification:(NSNotification *)notification{
    NSLog(@"theme change");
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
