//
//  ActivityWebViewController.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/5.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "ActivityWebViewController.h"
#import <WebKit/WebKit.h>
#import "UIFoundation.h"
#import <RKContainerHeader.h>

@interface ActivityWebViewController () <WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) WKWebViewConfiguration *webConfig;
@property (nonatomic, strong) WKUserContentController *userViewController;

@end

@implementation ActivityWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [NSURLProtocol wk_registerScheme:@"http"];
//    [NSURLProtocol wk_registerScheme:@"https"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Web活动页";
    self.webConfig.userContentController = self.userViewController;
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:self.webConfig];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:self.webView];
}
- (WKWebViewConfiguration *)webConfig
{
    if(_webConfig == nil)
    {
        _webConfig = [WKWebViewConfiguration new];
        
    }
    return _webConfig;
}
- (WKUserContentController *)userViewController
{
    if(_userViewController == nil)
    {
        _userViewController = [WKUserContentController new];
    }
    return _userViewController;
}
- (void)viewWillAppear:(BOOL)animated
{
     [self.userViewController addScriptMessageHandler:self name:@"Native"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.userViewController removeScriptMessageHandlerForName:@"Native"];
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([@"Native" isEqualToString:message.name]){
        if ([@"changeText" isEqualToString:message.body]){
            [self changeText];
        }
        if([@"pushVC" isEqualToString:message.body]){
            [self pushToVC];
        }
    }
}

#pragma mark - bridge function
- (void)changeText{
    id<RKNetworkProtocol> n = [[RKContainer sharedInstance] loadServiceForProtocol:@protocol(RKNetworkProtocol)];
    [n getWithSuccess:^(NSString * _Nonnull result) {
        NSLog(@"%@", result);
    } error:^(NSString * _Nonnull errorInfo) {
        NSLog(@"%@", errorInfo);
    }];
}

- (void)pushToVC{
    [[RKContainer sharedInstance].context.rootVC popToRootViewControllerAnimated:YES];
}
@end
