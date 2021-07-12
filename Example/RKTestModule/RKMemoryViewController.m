//
//  RKMemoryViewController.m
//  RKTestModule_Example
//
//  Created by 贾晓滨 on 2020/2/20.
//  Copyright © 2020 beedroid. All rights reserved.
//

#import "RKMemoryViewController.h"
#import "RKBigImageViewController.h"

@interface RKMemoryViewController ()
@property (nonatomic, strong) NSCache *memCache;

@end

@implementation RKMemoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupNavigationItems {
    self.title = @"内存管理";
    UIButton *testBigImageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    testBigImageButton.frame = CGRectMake(20, 88, 200, 50);
    [testBigImageButton setTitle:@"大图内存管理" forState:UIControlStateNormal];
    [testBigImageButton addTarget:self action:@selector(testBigImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBigImageButton];
    
    UIButton *heapButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    heapButton.frame = CGRectMake(20, 88+50, 200, 50);
    [heapButton setTitle:@"堆内存管理" forState:UIControlStateNormal];
    [heapButton addTarget:self action:@selector(rk_heap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:heapButton];
    
    UIButton *cacheButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cacheButton.frame = CGRectMake(20, 88+100, 200, 50);
    [cacheButton setTitle:@"缓存" forState:UIControlStateNormal];
    [cacheButton addTarget:self action:@selector(rk_cache) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cacheButton];
    
    UIButton *stackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    stackButton.frame = CGRectMake(20, 88+150, 200, 50);
    [stackButton setTitle:@"缓存" forState:UIControlStateNormal];
    [stackButton addTarget:self action:@selector(rk_stack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stackButton];
}

- (void)testBigImage{
    RKBigImageViewController *vc = [[RKBigImageViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rk_chache{
    
}

- (void)rk_heap{
    
}

- (void)rk_stack{
    
}

@end
