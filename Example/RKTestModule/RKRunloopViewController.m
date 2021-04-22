//
//  RKRunloopViewController.m
//  RKTestModule_Example
//
//  Created by 贾晓滨 on 2020/2/20.
//  Copyright © 2020 beedroid. All rights reserved.
//

#import "RKRunloopViewController.h"

@interface RKRunloopViewController ()

@end

@implementation RKRunloopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor qmui_randomColor];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"Runloop";
}

@end
