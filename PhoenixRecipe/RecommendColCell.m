//
//  RecommendColCell.m
//  PhoenixRecipe
//
//  Created by mini on 2017/11/23.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "RecommendColCell.h"

@implementation RecommendColCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self.contentView).offset(15);
//            make.height.equalTo(self.iconView.mas_width).multipliedBy(9/16.f);
            make.bottom.equalTo(self.titleLabel.mas_top).offset(-10);
            make.right.equalTo(self.contentView).offset(-15);
        }];
        
        
        [self.blurView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.iconView);
            make.height.mas_equalTo(40);
        }];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.blurView).insets(UIEdgeInsetsMake(5, 5, 5, 5));;
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(self.iconView);
            make.bottom.equalTo(self.tagLabel.mas_top).offset(-10);
            make.height.mas_equalTo(30);
            
        }];
        [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(self.iconView);
//            make.top.equalTo(self.iconView.mas_bottom).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
            make.height.mas_equalTo(20);
        }];
        
        
        
        
        
    }
    return self;
}
//- (UIVisualEffectView *)blurView{
//    if (!_blurView) {
//        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//        UIVisualEffectView *view = [[UIVisualEffectView alloc]initWithEffect:blur];
//        [self.iconView addSubview:view];
//        _blurView = view;
//    }
//    return _blurView;
//}
- (UIView *)blurView{
    if (!_blurView) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:CGRectMake(0, 0, 1000, 100) andColors:@[RGBA(0, 0, 0, 0),RGBA(0, 0, 0, 0.4)]];
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
        
//        icon.layer.shadowColor = rgba(0, 0, 0, 0.5).CGColor;
//        icon.layer.shadowRadius = 10;
//        icon.layer.shadowOffset = CGSizeMake(2, 2);
//        icon.layer.shadowOpacity = 0.9;
        icon.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        icon.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:icon];
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
        title.font = [UIFont boldSystemFontOfSize:12];
        title.textColor = [UIColor whiteColor];
        title.numberOfLines = 0;
        title.lineBreakMode = NSLineBreakByCharWrapping;
//        [self.blurView.contentView addSubview:title];
        [self.blurView addSubview:title];
        _descLabel = title;
    }
    return _descLabel;
}
@end
