//
//  RecipeListColCell.m
//  PhoenixRecipe
//
//  Created by mini on 2017/11/24.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "RecipeListColCell.h"

@implementation RecipeListColCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-5);
            make.left.equalTo(self.contentView).offset(5);
            make.top.equalTo(self.contentView).offset(5);
            make.height.equalTo(self.iconView.mas_width);
            
        }];
        
        
//        [self.blurView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.bottom.equalTo(self.iconView);
//            make.height.mas_equalTo(30);
//        }];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.blurView);
            make.bottom.lessThanOrEqualTo(self.contentView).offset(-5);
            make.right.equalTo(self.contentView).offset(-5);
            make.left.equalTo(self.contentView).offset(5);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-5);
            make.left.equalTo(self.contentView).offset(5);
            make.top.equalTo(self.iconView.mas_bottom).offset(5);
            make.height.mas_equalTo(30);
            
        }];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.contentView).offset(-5);
            make.left.equalTo(self.contentView).offset(5);
            make.height.mas_equalTo(0.5);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(-2.5);
        }];
        
//        [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.left.equalTo(self.iconView);
//            //            make.top.equalTo(self.iconView.mas_bottom).offset(10);
//            make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
//            make.height.mas_equalTo(20);
//        }];
        
        
        
        
        
    }
    return self;
}
- (UIView *)line{
    if (!_line) {
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:line];
        _line = line;
    }
    return _line;
}
- (UIImageView *)iconView{
    if (!_iconView) {
        UIImageView *icon = [[UIImageView alloc]init];
        icon.clipsToBounds = YES;
//        icon.layer.cornerRadius = 0.f;
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
- (UILabel *)descLabel{
    if (!_descLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.numberOfLines = 0;
        title.lineBreakMode = NSLineBreakByWordWrapping;
        title.textAlignment = NSTextAlignmentLeft;
        title.font = [UIFont boldSystemFontOfSize:14];
        title.textColor = [UIColor grayColor];
        [self.contentView addSubview:title];
        _descLabel = title;
    }
    return _descLabel;
}
//- (UIView *)bgView{
//    if (!_bgView) {
//        UIView *v = [[UIView alloc]init];
//        [self.contentView addSubview:v];
//        _bgView = v;
//    }
//    return _bgView;
//}
@end
