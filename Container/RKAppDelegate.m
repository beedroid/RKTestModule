//
//  RKAppDelegate.m
//  AFNetworking
//
//  Created by 贾晓滨 on 2021/7/10.
//

#import "RKAppDelegate.h"
#import "RKContainer.h"

static UIWindow *gWindow = nil;
@interface RKAppDelegate ()

@end

@implementation RKAppDelegate
@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[RKContainer sharedInstance] configEnv:RKEnvTypeDebug];
    [[RKContainer sharedInstance] loadAllModuleAndService];
    [[RKContainer sharedInstance] dispatchEvent:RKBeforeDidFinishLaunchingEvent];
    // 启动前
    gWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[[UIApplication sharedApplication] delegate] setWindow:gWindow];
    UINavigationController *navVC = [[UINavigationController alloc] init];
    gWindow.rootViewController = navVC;
    
    [[RKContainer sharedInstance] configRootNav:navVC];
    
    // 启动结束
    [[RKContainer sharedInstance] dispatchEvent:RKDidFinishLaunchingEvent];
    [gWindow makeKeyAndVisible];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 首屏展示结束
        [[RKContainer sharedInstance] dispatchEvent:RKAfterFinishLaunchingEvent];
    });
    return YES;
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[RKContainer sharedInstance] dispatchEvent:RKDidEnterBackgroundEvent];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[RKContainer sharedInstance] dispatchEvent:RKWillEnterForegroundEvent];
}
@end
