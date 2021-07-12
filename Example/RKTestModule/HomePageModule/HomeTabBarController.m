//
//  HomeTabBarController.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/3.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "HomeTabBarController.h"
#import <RKContainerHeader.h>
#import "UIFoundation.h"

#define kPageKey     @"PageVC"
#define kTitleKey       @"title"
#define kImgKey         @"imageName"
#define kSelImgKey      @"selectedImageName"

@interface HomeTabBarController () <UITabBarControllerDelegate>

@end

@implementation HomeTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *childItemsArray = [NSMutableArray arrayWithCapacity:4];
    
    id<RKChatProtocol> chatService = [[RKContainer sharedInstance] loadServiceForProtocol:@protocol(RKChatProtocol)];
    UIViewController *chatVC = [chatService entryPage];
    [childItemsArray addObject:@{kPageKey  : chatVC,
                                 kTitleKey  : @"微信",
                                 kImgKey    : @"tabbar_mainframe",
                                 kSelImgKey : @"tabbar_mainframeHL"}];
    id<RKContactsProtocol> contactsService = [[RKContainer sharedInstance] loadServiceForProtocol:@protocol(RKContactsProtocol)];
    UIViewController *contactsVC = [contactsService entryPage];
    [childItemsArray addObject:@{kPageKey  : contactsVC,
                                 kTitleKey  : @"通讯录",
                                 kImgKey    : @"tabbar_contacts",
                                 kSelImgKey : @"tabbar_contactsHL"}];
    id<RKDiscoverProtocol> discoverService = [[RKContainer sharedInstance] loadServiceForProtocol:@protocol(RKDiscoverProtocol)];
    UIViewController *discoverVC = [discoverService entryPage];
    [childItemsArray addObject:@{kPageKey   : discoverVC,
                                 kTitleKey  : @"发现",
                                 kImgKey    : @"tabbar_discover",
                                 kSelImgKey : @"tabbar_discoverHL"}];
    
    id<RKMineProtocol> mineService = [[RKContainer sharedInstance] loadServiceForProtocol:@protocol(RKTechProtocol)];
    UIViewController *mineVC = [mineService entryPage];
    [childItemsArray addObject:@{kPageKey  : mineVC,
                                 kTitleKey  : @"我",
                                 kImgKey    : @"tabbar_me",
                                 kSelImgKey : @"tabbar_meHL"}];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = (UIViewController *)dict[kPageKey];
        vc.title = dict[kTitleKey];
        UITabBarItem *item = vc.tabBarItem;
        item.title = dict[kTitleKey];
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : Global_tintColor} forState:UIControlStateSelected];
        [self addChildViewController:vc];
    }];
    
    self.delegate = self;
    self.title = self.viewControllers[0]?self.viewControllers[0].title:@"微信";
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    self.title = viewController.title;
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
