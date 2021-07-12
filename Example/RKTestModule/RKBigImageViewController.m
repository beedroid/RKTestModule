//
//  RKBigImageViewController.m
//  RKTestModule_Example
//
//  Created by 贾晓滨 on 2020/2/20.
//  Copyright © 2020 beedroid. All rights reserved.
//

#import "RKBigImageViewController.h"
#import <RKBaseModule/RKGlobalValue.h>
#import <UIImageView+WebCache.h>

#define RKRandNum(i) arc4random()%i   // [0,i) 范围内随机数

@interface RKBigImageViewController ()

@end

@implementation RKBigImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"大图加载列表";
}

#pragma mark - TableView delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 999;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_WIDTH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
        imageView.tag = 1001;
        [cell.contentView addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        titleLabel.tag = 1002;
        titleLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        [cell.contentView addSubview:titleLabel];
    }else{
        //重置cell状态
        UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:1001];
        UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:1002];
        titleLabel.text = @"";
        [imageView sd_setImageWithURL:nil];
    }
    
    //给cell配置数据模版
    //https://picsum.photos/200/300
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:1001];
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:1002];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://picsum.photos/2200/2200?random=%d", RKRandNum(999)]];
    [imageView sd_setImageWithURL:url
                 placeholderImage:nil
                          options:SDWebImageCacheMemoryOnly
                         progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        NSString *text = [NSString stringWithFormat:@"已下载：%ldKB/%ldKB", lround(receivedSize/1024.0), lround(expectedSize/1024.0)];
        dispatch_async(dispatch_get_main_queue(), ^{
            titleLabel.text = text;
        });
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"Complated");
    }];
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
    NSLog(@"1");
}



@end
