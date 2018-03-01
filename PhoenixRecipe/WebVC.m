
//
//  WebVC.m
//  PhoenixRecipe
//
//  Created by Apple on 2017/12/4.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "WebVC.h"
#import "Reachability.h"
@interface WebVC ()<UIWebViewDelegate>
@property(nonatomic, weak) UIWebView *webView;
@property(nonatomic, strong) Reachability *reachability;
@property(nonatomic, assign) BOOL loadSuccess;

@end

@implementation WebVC

@synthesize webUrl = _webUrl;

- (UIWebView *)webView{
    if (!_webView) {
        UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        webView.delegate = self;
        [self.view addSubview:webView];
        
        [webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(TopPadding);
            make.bottom.equalTo(self.view).offset(-BottomPadding);
        }];
        
        _webView = webView;
    }
    return _webView;
}
//- (void)setWebUrl:(NSString *)webUrl{
//    _webUrl = webUrl;
//    [self loadRequest];
//}
- (NSString *)webUrl{
    if (!_webUrl) {
        _webUrl = @"baidu.com";
    }
    return _webUrl;
}
- (void)loadRequest{
    
    if(!self.webView.isLoading){
        [WSProgressHUD showWithStatus:@"加载中..."];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ThemeColor;
    self.loadSuccess = NO;
    [self loadRequest];
//    [WSProgressHUD setDefaultStyle:WSProgressHUDStyleDark];
    // Reachability使用了通知，当网络状态发生变化时发送通知kReachabilityChangedNotification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appReachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    self.reachability = [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
    [self loadRequest];
}
/// 当网络状态发生变化时调用
- (void)appReachabilityChanged:(NSNotification *)notification{
    Reachability *reach = [notification object];
    if([reach isKindOfClass:[Reachability class]]){
        NetworkStatus status = [reach currentReachabilityStatus];
        switch (status) {
            case NotReachable:
                [WSProgressHUD showImage:[UIImage imageNamed:@"info"] status:@"已断开网络连接"];
                break;
            default:
                [WSProgressHUD showSuccessWithStatus:@"网络已连接"];
                if(!self.loadSuccess)
                    [self loadRequest];
                break;
        }
    }
}
/// 取消通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}





- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    switch (self.reachability.currentReachabilityStatus) {
        case NotReachable:
            
            [WSProgressHUD showImage:[UIImage imageNamed:@"info"] status:@"已断开网络连接"];
            return;
        default:
            
            break;
    }
    [WSProgressHUD showWithStatus:@"加载中..."];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [WSProgressHUD dismiss];
    self.loadSuccess = YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    switch (self.reachability.currentReachabilityStatus) {
        case NotReachable:
            [WSProgressHUD showImage:[UIImage imageNamed:@"info"] status:@"已断开网络连接"];
            return;
        default:
            [WSProgressHUD showErrorWithStatus:@"加载失败"];
            break;
    }
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}



@end
