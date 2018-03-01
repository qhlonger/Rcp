
//
//  CoverView.m
//  PhoenixRecipe
//
//  Created by Apple on 2017/12/2.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "CoverView.h"
#import "AppDelegate.h"
@implementation CoverView


+ (instancetype)sharedInstance{
    static CoverView *cover = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cover = [[CoverView alloc]init];
        
    });
    return cover;
}

- (void)show{
    UIWindow *window=((AppDelegate*)[[UIApplication sharedApplication] delegate]).window;
    self.bgView.frame = window.bounds;
    self.iconView.frame = window.bounds;
    
    self.actView.center = CGPointMake(CGRectGetWidth(self.bgView.frame)/2, CGRectGetHeight(self.bgView.frame)*0.7);
    
    [window addSubview:self.bgView];
    
    
        [self.actView startAnimating];
        self.bgView.alpha = 1.f;
    //self.iconView.alpha = 1.f;
    
}

- (void)hide{
    [self.actView stopAnimating];
    
    [UIView animateWithDuration:1 animations:^{
        self.bgView.alpha = 0.f;
        self.bgView.transform = CGAffineTransformMakeScale(2, 2);
    } completion:^(BOOL finished) {
        self.bgView.transform = CGAffineTransformMakeScale(1, 1);
        [self.bgView removeFromSuperview];
    }];
    
    
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
}
- (UIImageView *)bgView{
    if (!_bgView) {
        UIImageView *icon = [[UIImageView alloc]init];
        icon.clipsToBounds = YES;
        icon.alpha = 0.f;
        //        icon.layer.cornerRadius = 0.f;
        icon.contentMode = UIViewContentModeScaleAspectFill;
        icon.image = [UIImage imageNamed:@"bg"];
        icon.backgroundColor = [UIColor whiteColor];
        [self addSubview:icon];
        _bgView = icon;
    }
    return _bgView;
}

- (UIImageView *)iconView{
    if (!_iconView) {
        UIImageView *icon = [[UIImageView alloc]init];
        icon.clipsToBounds = YES;
        //icon.alpha = 0.f;
        //        icon.layer.cornerRadius = 0.f;
        icon.contentMode = UIViewContentModeCenter;
        icon.image = [UIImage imageNamed:@"icon_white"];
//        icon.backgroundColor = [UIColor whiteColor];
        [self.bgView addSubview:icon];
        _iconView = icon;
    }
    return _iconView;
}

- (UIActivityIndicatorView *)actView{
    if (!_actView) {
        _actView = [[UIActivityIndicatorView alloc]init];
        _actView.frame = CGRectMake(0, 0, 40, 40);
        _actView.color = ThemeColor;
        _actView.hidesWhenStopped = YES;
        [self.bgView addSubview:_actView];
    }
    return _actView;
}

    
    


@end
