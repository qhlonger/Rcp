//
//  AboutVC.m
//  PhoenixRecipe
//
//  Created by Apple on 2017/12/2.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "AboutVC.h"

@interface AboutVC ()<UIWebViewDelegate>
@property(nonatomic, weak) UIImageView *iconView;
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UILabel *versionLabel;
@property(nonatomic, weak) UIView *shadowBg;

@property(nonatomic, weak) UIWebView *aboutView;

@end

@implementation AboutVC


- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"关于";
    [self.aboutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.aboutView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://sqdao4.xyz/app_manage/pkrecipesupport"]]]];
    
    [self.view startLoading];
}
- (UIWebView *)aboutView{
    if (!_aboutView) {
        UIWebView *web = [[UIWebView alloc]init];
        web.backgroundColor = [UIColor whiteColor];
        web.delegate = self;
        [self.view addSubview:web];
        _aboutView = web;
    }
    return _aboutView;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.view stopLoading];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.view stopLoading];
}












- (void)viewDidLo1ad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"关于";
    
    [self shadowBg];
    
    [self layout];
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    
    // 获取App的版本号
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    // 获取App的build版本
    NSString *appBuildVersion = [infoDic objectForKey:@"CFBundleVersion"];
    
    // 获取App的名称
    NSString *appName = [infoDic objectForKey:@"CFBundleDisplayName"];
                         
    self.titleLabel.text = appName;
    
    
    self.versionLabel.text = [NSString stringWithFormat:@"%@(%@)",appVersion,appBuildVersion];
    self.iconView.image = [UIImage imageNamed:@"icon_white"];
    
    
    
    
    
    
}
- (void)layout{
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).multipliedBy(0.8);
        make.width.height.mas_equalTo(120);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.iconView.mas_bottom).offset(20);
        make.width.equalTo(self.view.mas_width);
    }];
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
        make.width.equalTo(self.view.mas_width);
    }];
    [self.shadowBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.iconView);
    }];
    
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont boldSystemFontOfSize:24];
        title.textColor = [UIColor blackColor];
        [self.view addSubview:title];
        _titleLabel = title;
    }
    return _titleLabel;
}
- (UILabel *)versionLabel{
    if (!_versionLabel) {
        UILabel *version = [[UILabel alloc]init];
        version.textAlignment = NSTextAlignmentCenter;
        version.font = [UIFont boldSystemFontOfSize:18];
        version.textColor = [UIColor darkGrayColor];
        [self.view addSubview:version];
        _versionLabel = version;
    }
    return _versionLabel;
}
- (UIImageView *)iconView{
    if (!_iconView) {
        UIImageView *icon = [[UIImageView alloc]init];
        icon.clipsToBounds = YES;
        icon.layer.cornerRadius = 20.f;
        icon.layer.masksToBounds = YES;
        
        icon.layer.shadowColor = rgba(0, 0, 0, 0.5).CGColor;
        icon.layer.shadowRadius = 40;
        icon.layer.shadowOffset = CGSizeMake(4, 4);
        icon.layer.shadowOpacity = 0.9;
        
        icon.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:icon];
        _iconView = icon;
    }
    return _iconView;
}
- (UIView *)shadowBg{
    if (!_shadowBg){
        UIView *v = [[UIView alloc]init];
        
//        v.clipsToBounds = YES;
        v.layer.cornerRadius = 20.f;
//        v.layer.masksToBounds = YES;
        v.backgroundColor = [UIColor whiteColor];
        v.layer.shadowColor = rgba(0, 0, 0, 0.5).CGColor;
        v.layer.shadowRadius = 10;
        v.layer.shadowOffset = CGSizeMake(2, 2);
        v.layer.shadowOpacity = 0.9;
        
        [self.view addSubview:v];
        _shadowBg = v;
    }
    return _shadowBg;
}

@end
