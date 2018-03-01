//
//  AllColCell.m
//  PhoenixRecipe
//
//  Created by mini on 2017/11/23.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "AllColCell.h"

@implementation AllColCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.contentView).offset(20);
            make.bottom.equalTo(self.contentView).offset(-20);
        }];
        
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.iconView);
        }];
        [self.bgTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.iconView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
        }];
        
//        [self.blurView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.right.bottom.equalTo(self.iconView);
////            make.height.mas_equalTo(40);
//        }];
//        
        
        
        
        
        
    }
    return self;
}
- (UIVisualEffectView *)blurView{
    if (!_blurView) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *view = [[UIVisualEffectView alloc]initWithEffect:blur];
//        [self.iconView addSubview:view];
        _blurView = view;
    }
    return _blurView;
}
- (UIImageView *)iconView{
    if (!_iconView) {
        UIImageView *icon = [[UIImageView alloc]init];
        icon.clipsToBounds = YES;
        icon.layer.cornerRadius = 5.f;
        icon.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:icon];
        _iconView = icon;
    }
    return _iconView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.textAlignment = NSTextAlignmentCenter;
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        title.font = [UIFont boldSystemFontOfSize:30];
        title.textColor = [UIColor whiteColor];
        [self.contentView addSubview:title];
        _titleLabel = title;
    }
    return _titleLabel;
}
- (UILabel *)bgTextLabel{
    if (!_bgTextLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont boldSystemFontOfSize:60];
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        title.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
        [self.contentView addSubview:title];
        _bgTextLabel = title;
    }
    return _bgTextLabel;
}
@end
