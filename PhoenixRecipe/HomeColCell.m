
//
//  HomeColCell.m
//  PhoenixRecipe
//
//  Created by Apple on 2017/12/1.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "HomeColCell.h"

@implementation HomeColCell
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
            make.left.equalTo(self.blurView).offset(10);
            make.right.equalTo(self.blurView).offset(-10);
            make.height.mas_equalTo(24);
            make.bottom.equalTo(self.blurView).offset(-5);
        }];
        
                [self.blurView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.bottom.equalTo(self.iconView);
                    make.height.mas_equalTo(30);
                }];
        //
        
        
        
        
        
    }
    return self;
}
- (UIVisualEffectView *)blurView{
    if (!_blurView) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *view = [[UIVisualEffectView alloc]initWithEffect:blur];
        [self.iconView addSubview:view];
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
        title.font = [UIFont boldSystemFontOfSize:18];
        title.textColor = [UIColor blackColor];
        [self.blurView.contentView addSubview:title];
        _titleLabel = title;
    }
    return _titleLabel;
}
- (UILabel *)descLabel{
    if (!_descLabel) {
        UILabel *descLabel = [[UILabel alloc]init];
        descLabel.textAlignment = NSTextAlignmentCenter;
        descLabel.font = [UIFont boldSystemFontOfSize:16];
        descLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:descLabel];
        _descLabel = descLabel;
    }
    return _descLabel;
    
}
@end
