//
//  RKNetworkViewController.m
//  RKTestModule_Example
//
//  Created by 贾晓滨 on 2020/2/26.
//  Copyright © 2020 beedroid. All rights reserved.
//

#import "RKNetworkViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface RKNetworkViewController ()

@end

@implementation RKNetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor qmui_randomColor];
    NSURLCache *c = [[NSURLCache alloc] initWithMemoryCapacity:100 diskCapacity:100 diskPath:nil];
    [[AFHTTPSessionManager manager] GET:@"https://api.apiopen.top/recommendPoetry" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"downloadProgress");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success");
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"Network";
}


@end
