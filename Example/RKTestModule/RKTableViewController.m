//
//  RKTableViewController.m
//  RKTestModule_Example
//
//  Created by 贾晓滨 on 2021/4/22.
//  Copyright © 2021 beedroid. All rights reserved.
//

#import "RKTableViewController.h"
#import <RKBaseModule/RKGlobal.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDWebImageManager.h>

@interface RKTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation RKTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"列表页优化";
    // 创建数据源
    NSMutableArray *picList = [[NSMutableArray alloc] init];
    for (int i=0; i<100; i++) {
        NSString *picUrl = [NSString stringWithFormat:@"https://picsum.photos/seed/%d/2000/3000", arc4random() % 100];
        [picList addObject:picUrl];
    }
    self.dataArray = [NSArray arrayWithArray:picList];
//    self.dataArray = @[];
    
    //创建视图
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64.0)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
#pragma mark - TableView delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }else{
        //重置cell状态
    }
    
    //给cell配置数据模版
    cell.textLabel.text = @"行内容";
    NSString *urlStr = [self.dataArray objectAtIndex:indexPath.row];
    //赋值原图
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:urlStr]
                      placeholderImage:[UIImage imageNamed:@"icon_nav_about"]];
    // 使用UIKit生成缩略图
//    SDWebImageManager *manager = [SDWebImageManager sharedManager];
//    [manager loadImageWithURL:[NSURL URLWithString:urlStr] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//            //
//        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
//            if (image) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    cell.imageView.image = [self ui_thumbnailWithImage:image size:CGSizeMake(44, 44)];
//
//                });
//            }
//        }];
    // 使用CG生成缩略图
//    SDWebImageManager *manager = [SDWebImageManager sharedManager];
//    [manager loadImageWithURL:[NSURL URLWithString:urlStr] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//            //
//        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
//            if (image) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    cell.imageView.image = image;
//                });
//            }
//        }];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", indexPath.row);
//    [[SDImageCache sharedImageCache] clearMemory];
//    [[SDWebImageManager sharedManager].imageCache clearMemory];
   
    for (int i=0; i<self.dataArray.count; i++) {
        NSString *image_url = [self.dataArray objectAtIndex:i];
        [[SDImageCache sharedImageCache] removeImageForKey:image_url fromDisk:YES withCompletion:^{
            NSLog(@"comp");
        }];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIImage *)ui_thumbnailWithImage:(UIImage *)image size:(CGSize)asize{
    UIGraphicsBeginImageContext(asize);
    [image drawInRect:CGRectMake(0, 0, asize.width, asize.height)];
    UIImage *newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimage;
}

+ (UIImage *)cg_thumbnailWithImage:(UIImage *)image size:(CGSize)size
{
    CGFloat scale = MAX(size.width/image.size.width, size.height/image.size.height);
    CGFloat width = image.size.width * scale;
    CGFloat height = image.size.height * scale;
    CGRect imageRect = CGRectMake((size.width - width)/2.0f,
                                  (size.height - height)/2.0f,
                                  width,
                                  height);

    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [image drawInRect:imageRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
