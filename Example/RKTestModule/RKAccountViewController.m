//
//  RKAccountViewController.m
//  RKTestModule_Example
//
//  Created by 贾晓滨 on 2020/2/15.
//  Copyright © 2020 beedroid. All rights reserved.
//

#import "RKAccountViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface RKAccountViewController ()

@end

@implementation RKAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 200)];
    [iv sd_setImageWithURL:[NSURL URLWithString:@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201504%2F10%2F20150410H3211_zhaVu.jpeg&refer=http%3A%2F%2Fimg3.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1621132105&t=808df06ed970eaff353a470f22228a41"]];
    [self.view addSubview:iv];
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
