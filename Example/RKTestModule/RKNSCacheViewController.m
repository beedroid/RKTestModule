//
//  RKNSCacheViewController.m
//  RKTestModule_Example
//
//  Created by 贾晓滨 on 2020/2/20.
//  Copyright © 2020 beedroid. All rights reserved.
//

#import "RKNSCacheViewController.h"

@interface RKNSCacheViewController ()

@end

@implementation RKNSCacheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor qmui_randomColor];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"NSCache";
}

@end
