//
//  ViewController.m
//  faye-ios
//
//  Created by gxw on 13-11-14.
//  Copyright (c) 2013年 gxw. All rights reserved.
//

#import "ViewController.h"
#import "FayeClient.h"

@interface ViewController () <FayeClientDelegate>
@property (nonatomic, strong) FayeClient *client;
@end

@implementation ViewController

- (void)loadView{
    [super loadView];
    
    UIView *view=[[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    view.alpha=0.5;
    view.backgroundColor=[UIColor cyanColor];
    self.view = view;
    
    self.label = [[UITextView alloc] initWithFrame:CGRectMake(10, 50, 300, 200)];
    [self.view addSubview:self.label];
    self.label.text = @"receving message.....";
    
    NSLog(@"分辨率: %@",  [[UIScreen mainScreen] bounds]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _client = [[FayeClient alloc] initWithURLString:@"ws://localhost:9292/faye" channel:@"/foo"];
    _client.delegate = self;
    [_client connectToServer];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_client disconnectFromServer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Faye Client Delegate
- (void)connectedToServer
{
    NSLog(@"Connected to server");
}

- (void)disconnectedFromServer
{
    NSLog(@"Disconnected from server");
}

- (void)subscriptionFailedWithError:(NSString *)error
{
    NSLog(@"Subscription did fail: %@", error);
}

- (void)subscribedToChannel:(NSString *)channel
{
    NSLog(@"Subscribed to channel: %@", channel);
}

- (void)messageReceived:(NSDictionary *)messageDict channel:(NSString *)channel
{
    NSString *string = [NSString stringWithFormat:@"messageReceived %@ by channel: %@",messageDict, channel];
    NSLog(string);
    self.label.text = string;
}
- (void)connectionFailed
{
    NSLog(@"Connection Failed");
}
- (void)didSubscribeToChannel:(NSString *)channel
{
    NSLog(@"didSubscribeToChannel %@", channel);
    [_client sendMessage:@{@"jayztemplier" : @"Hello World! everyone!"} onChannel:@"/foo"];
}
- (void)didUnsubscribeFromChannel:(NSString *)channel
{
    NSLog(@"didUnsubscribeFromChannel %@", channel);
}
- (void)fayeClientError:(NSError *)error
{
    NSLog(@"fayeClientError %@", error);
}



@end
