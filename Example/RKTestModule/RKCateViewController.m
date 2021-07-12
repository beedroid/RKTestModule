//
//  RKCateViewController.m
//  RKTestModule_Example
//
//  Created by 贾晓滨 on 2020/2/15.
//  Copyright © 2020 beedroid. All rights reserved.
//

#import "RKCateViewController.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>
#import "RKPerson.h"
#import "RKStudent.h"

@interface RKCateViewController ()

@end

@implementation RKCateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSObject *o = [[NSObject alloc] init];
    NSLog(@"对象实际需要的内存大小: %zd", class_getInstanceSize([NSObject class]));// 8
    NSLog(@"对象实际分配的内存大小: %zd", malloc_size((__bridge const void *)(o)));// 16
    
    RKPerson *person = [[RKPerson alloc] init];
    person.score = 100;
    NSLog(@"对象实际需要的内存大小: %zd", class_getInstanceSize([RKPerson class]));// 16
    NSLog(@"对象实际分配的内存大小: %zd", malloc_size((__bridge const void *)(person)));// 16
    
    RKStudent *student = [[RKStudent alloc] init];
    NSLog(@"对象实际需要的内存大小: %zd", class_getInstanceSize([RKStudent class]));// 16
    NSLog(@"对象实际分配的内存大小: %zd", malloc_size((__bridge const void *)(student)));// 16
    
    RKPerson *person2 = [person copy];
    person2.score = 99;
    NSLog(@"%d--%d",person2.score, person.score);
    
    RKPerson *p3 = [person mutableCopy];
    person.score = 98;
    NSLog(@"%d--%d--%d",p3.score, person.score, person2.score);
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
