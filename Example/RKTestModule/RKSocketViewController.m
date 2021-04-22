//
//  RKSocketViewController.m
//  RKTestModule_Example
//
//  Created by 贾晓滨 on 2020/2/26.
//  Copyright © 2020 beedroid. All rights reserved.
//

#import "RKSocketViewController.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>

@interface RKSocketViewController ()<GCDAsyncSocketDelegate>
@property (nonatomic, strong) GCDAsyncSocket *socket;
@end

@implementation RKSocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor qmui_randomColor];
    UIButton *createButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    createButton.frame = CGRectMake(20, 88, 200, 50);
    [createButton setTitle:@"CONNECT" forState:UIControlStateNormal];
    [createButton addTarget:self action:@selector(connectToServer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createButton];

    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sendButton.frame = CGRectMake(20, 88+60, 200, 50);
    [sendButton setTitle:@"SEND: 消息内容" forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(closeToServer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];

    UIButton *reconnectButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    reconnectButton.frame = CGRectMake(20, 88+60+60, 200, 50);
    [reconnectButton setTitle:@"RECONNECT" forState:UIControlStateNormal];
    [reconnectButton addTarget:self action:@selector(reconnectToServer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reconnectButton];

    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeButton.frame = CGRectMake(20, 88+60+60+60, 200, 50);
    [closeButton setTitle:@"CLOSE" forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeToServer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    
   
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"Network";
}

- (void)connectToServer:(id)sender {
    // 创建socket
    if (self.socket == nil) {
        self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    }
    // 连接socket
    if (!self.socket.isConnected){
        NSError *error;
        [self.socket connectToHost:@"192.168.2.106" onPort:8080 withTimeout:-1 error:&error];
        if (error) NSLog(@"%@",error);
    }
}
- (void)sendMessage:(id)sender {
    NSData *data = [@"message content < com from iPhone Simulator>" dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:data withTimeout:-1 tag:10086];
}

- (void)reconnectToServer:(id)sender {
    // 创建socket
    if (self.socket == nil)
        self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    // 连接socket
    if (!self.socket.isConnected){
        NSError *error;
        [self.socket connectToHost:@"127.0.0.1" onPort:8040 withTimeout:-1 error:&error];
        if (error) NSLog(@"%@",error);
    }
}
- (void)closeToServer:(id)sender {
    [self.socket disconnect];
    self.socket = nil;
}

#pragma mark - Socket代理方法
//已经连接到服务器
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(nonnull NSString *)host port:(uint16_t)port{
    NSLog(@"连接成功 : %@---%d",host,port);
    // 连接成功或者收到消息，必须开始read，否则将无法收到消息,
    // 不read的话，缓存区将会被关闭
    // -1 表示无限时长 ,永久不失效
    [self.socket readDataWithTimeout:-1 tag:10086];
}

// 连接断开
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"断开 socket连接 原因:%@",err);
}

//已经接收服务器返回来的数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"接收到tag = %ld : %ld 长度的数据",tag,data.length);
    //连接成功或者收到消息，必须开始read，否则将无法收到消息
    //不read的话，缓存区将会被关闭
    // -1 表示无限时长 ， tag
    [self.socket readDataWithTimeout:-1 tag:10086];
}

//消息发送成功 代理函数 向服务器 发送消息
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"%ld 发送数据成功",tag);
}

@end
