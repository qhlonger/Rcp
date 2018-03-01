//
//  Img9RecommendColCell.m
//  PhoenixRecipe
//
//  Created by Apple on 2018/2/1.
//  Copyright © 2018年 mini. All rights reserved.
//

#import "Img9RecommendColCell.h"

@implementation Img9RecommendColCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.imgBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self.contentView).offset(15);
            //            make.height.equalTo(self.iconView.mas_width).multipliedBy(9/16.f);
            make.bottom.equalTo(self.titleLabel.mas_top).offset(-10);
            make.right.equalTo(self.contentView).offset(-15);
        }];
        
        
//        [self.blurView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.bottom.equalTo(self.imgBgView);
//            make.height.mas_equalTo(30);
//        }];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.blurView);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(self.imgBgView);
            make.bottom.equalTo(self.tagLabel.mas_top).offset(-10);
            make.height.mas_equalTo(30);
            
        }];
        [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(self.imgBgView);
            //            make.top.equalTo(self.iconView.mas_bottom).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
            make.height.mas_equalTo(20);
        }];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.imgBgView);
            make.width.equalTo(self.iconView.mas_height);
            make.width.equalTo(self.imgBgView).multipliedBy(1);
        }];
        self.iconView.transform = CGAffineTransformMakeRotation(M_PI * 0.25);
        
        
        
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
- (Img9View *)iconView{
    if (!_iconView) {
        Img9View *icon = [[Img9View alloc]init];
        icon.contentMode = UIViewContentModeScaleAspectFill;
        icon.layer.anchorPoint = CGPointMake(0.7, 0.7);
        [self.imgBgView addSubview:icon];
        _iconView = icon;
    }
    return _iconView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.textAlignment = NSTextAlignmentLeft;
        title.font = [UIFont boldSystemFontOfSize:18];
        title.textColor = [UIColor blackColor];
        [self.contentView addSubview:title];
        _titleLabel = title;
    }
    return _titleLabel;
}
- (UILabel *)tagLabel{
    if (!_tagLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.textAlignment = NSTextAlignmentLeft;
        title.font = [UIFont boldSystemFontOfSize:16];
        title.textColor = ThemeColor;
        [self.contentView addSubview:title];
        _tagLabel = title;
    }
    return _tagLabel;
}
- (UILabel *)descLabel{
    if (!_descLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.textAlignment = NSTextAlignmentLeft;
        title.font = [UIFont boldSystemFontOfSize:14];
        title.textColor = [UIColor blackColor];
        [self.blurView.contentView addSubview:title];
        _descLabel = title;
    }
    return _descLabel;
}
- (UIView *)imgBgView{
    if (!_imgBgView) {
        UIView *img = [[UIView alloc]init];
        img.clipsToBounds = YES;
        
//
//        img.layer.shadowColor = rgba(0, 0, 0, 0.5).CGColor;
//        img.layer.shadowRadius = 10;
//        img.layer.shadowOffset = CGSizeMake(2, 2);
//        img.layer.shadowOpacity = 0.9;
        img.layer.cornerRadius = 5.f;
        [self.contentView addSubview:img];
        _imgBgView = img;
    }
    return _imgBgView;
}
@end
