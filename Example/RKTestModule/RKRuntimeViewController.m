//
//  RKRuntimeViewController.m
//  RKTestModule_Example
//
//  Created by 贾晓滨 on 2021/6/17.
//  Copyright © 2021 beedroid. All rights reserved.
//

#import "RKRuntimeViewController.h"
#import "RKGirlFriend.h"

@interface RKRuntimeViewController ()

@end

@implementation RKRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(20, 88, 200, 50);
    [button setTitle:@"步骤1：方法查找" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(say1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.frame = CGRectMake(20, 88+60, 200, 50);
    [button1 setTitle:@"步骤2：动态解析" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(say2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame = CGRectMake(20, 88+60*2, 200, 50);
    [button2 setTitle:@"步骤3：快速转发（备胎）" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(say3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button3.frame = CGRectMake(20, 88+60*3, 200, 50);
    [button3 setTitle:@"步骤4：慢速转发（备胎）" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(say4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button4.frame = CGRectMake(20, 88+60*4, 200, 50);
    [button4 setTitle:@"步骤5：实在找不到转不走做容错" forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(say5) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
}

- (void)say1{
    RKGirlFriend *gf = [[RKGirlFriend alloc] init];
    [gf performSelector:@selector(sayMessage1:) withObject:@"MSG1"];
}

- (void)say2{
//    RKGirlFriend *gf = [[RKGirlFriend alloc] init];
    // 测试对象方法转发
//    [gf performSelector:@selector(sayCMessage:) withObject:@"MSG2"];
//    [gf performSelector:@selector(sayOCMessage:) withObject:@"MSG2"];
    // 测试类方法转发
    [RKGirlFriend performSelector:@selector(sayPlusMessage:) withObject:@"Plus-MSG"];
}
- (void)say3{
    RKGirlFriend *gf = [[RKGirlFriend alloc] init];
    [gf performSelector:@selector(sayMessage3:) withObject:@"MSG3"];
    
}
- (void)say4{
    RKGirlFriend *gf = [[RKGirlFriend alloc] init];
    [gf performSelector:@selector(sayMessage4:) withObject:@"MSG4"];
    
}
- (void)say5{
    RKGirlFriend *gf = [[RKGirlFriend alloc] init];
    [gf performSelector:@selector(sayMessage5:) withObject:@"MSG5"];
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
