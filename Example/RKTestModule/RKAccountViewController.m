//
//  RKAccountViewController.m
//  RKTestModule_Example
//
//  Created by 贾晓滨 on 2020/2/15.
//  Copyright © 2020 beedroid. All rights reserved.
//

#import "RKAccountViewController.h"
#import <RKBaseModule/RKGlobalValue.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface RKAccountViewController ()

@end

@implementation RKAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账户中心";
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

// 商品打标
- (void)productFlag{
    UIImage *image = [UIImage imageNamed:@"flag_bg"];
    image = [UIImage imageWithCGImage:image.CGImage scale:3.0 orientation:UIImageOrientationUp];
    
    
    CGFloat top = image.size.height/3.0;
    CGFloat left = image.size.width/3.0;
    CGFloat bottom = image.size.height/3.0;
    CGFloat right = image.size.width/3.0;
    UIImage *img = [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right) resizingMode:UIImageResizingModeStretch];
    
    //状态栏背景色
    if (@available(iOS 12.0, *)) {
        //当版本>=12.0时
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right) resizingMode:UIImageResizingModeStretch];
    } else {
        //当版本<12.0时
        image = [image stretchableImageWithLeftCapWidth:left topCapHeight:top];
    }
    CGRect rect = CGRectMake(0, 0, 200, 20);
    UIGraphicsBeginImageContextWithOptions (rect.size, NO, [UIScreen mainScreen].scale);
    
    NSString *str = @"Hello World";
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary*attribute = @{NSFontAttributeName:[UIFont fontWithName:@"Georgia" size:12],NSParagraphStyleAttributeName:paragraphStyle};
    [str drawInRect:rect withAttributes:attribute];
    
    // drawInRect做了什么？
    [img drawInRect:rect];
    
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(10, 250, 200, 20);
    imgView.image = newImage;
    [self.view addSubview:imgView];
}

@end
