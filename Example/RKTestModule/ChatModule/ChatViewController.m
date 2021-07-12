//
//  ChatViewController.m
//  RKMicAppContainerModule_Example
//
//  Created by 贾晓滨 on 2021/7/3.
//  Copyright © 2021 贾晓滨. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatItemViewModule.h"
#import "ChatTableViewCell.h"
#import "UIFoundation.h"
#import <RKContainerHeader.h>

#define kChatViewControllerCellId @"ChatViewController"

@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Mock数据
    for (int i = 0; i < 10; i++) {
        int randomIndex = arc4random_uniform((int)24);
        ChatItemViewModule *model = [[ChatItemViewModule alloc] init];
        model.imageName = [NSString stringWithFormat:@"%d.jpg", randomIndex];
        // [NSString stringWithFormat:@"https://dummyimage.com/200x300&text=HELLO-%d!", randomIndex];
        model.name = @"name";
        model.message = @"@name";
        [self.dataArray addObject:model];
    }
    // 配置导航样式
    
    self.tableView.rowHeight = [ChatTableViewCell fixedHeight];
    
    [self.tableView registerClass:[ChatTableViewCell class] forCellReuseIdentifier:kChatViewControllerCellId];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (UISearchController *)searchController
{
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:[UIViewController new]];
    }
    return _searchController;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - TableView delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kChatViewControllerCellId];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<RKActivityWebProtocol> activityWebService = [[RKContainer sharedInstance] loadServiceForProtocol:@protocol(RKActivityWebProtocol)];
    UIViewController *vc = [activityWebService entryPage];
    [[RKContainer sharedInstance].context.rootVC pushViewController:vc animated:YES];
}

#pragma mark - des
- (NSString *)description{
    return NSStringFromClass([self class]);
}

@end
