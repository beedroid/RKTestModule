//
//  RKViewController.m
//  RKTestModule
//
//  Created by beedroid on 12/26/2019.
//  Copyright (c) 2019 beedroid. All rights reserved.
//

#import "RKViewController.h"
#import <RKTestModule/RKTestViewController.h>
#import <AFNetworking/AFNetworking.h>
#import <JLRoutes/JLRoutes.h>

@interface RKViewController ()

@end

@implementation RKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 50);
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitle:@"click" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(c)  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)c{
    RKTestViewController * vc = [[RKTestViewController alloc] init];
    [self presentViewController:vc animated:YES completion:^{
        NSLog(@"success");
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
