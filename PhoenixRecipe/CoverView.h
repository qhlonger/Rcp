//
//  CoverView.h
//  PhoenixRecipe
//
//  Created by Apple on 2017/12/2.
//  Copyright © 2017年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoverView : UIView

@property(nonatomic, strong) UIActivityIndicatorView *actView;
@property(nonatomic, strong) UIImageView *bgView;
@property(nonatomic, strong) UIImageView *iconView;
+ (instancetype)sharedInstance;

- (void)show;

- (void)hide;
@end
