

//
//  RecipeProcessCell.m
//  PhoenixRecipe
//
//  Created by mini on 2017/11/24.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "RecipeProcessCell.h"

@implementation RecipeProcessCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(15);
            make.width.mas_equalTo(140);
            make.height.mas_equalTo(140);
            make.bottom.equalTo(self.contentView).offset(-15).priorityLow;
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_right).offset(10);
            make.top.equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView);
            make.height.lessThanOrEqualTo(self.iconView);
            
//            make.height.mas_greaterThanOrEqualTo(10);
            
        }];
        [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView);
            make.top.equalTo(self.iconView);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(40);
        }];
//        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.right.equalTo(self.titleLabel);
//            make.height.mas_greaterThanOrEqualTo(self.iconView.mas_height);
//            make.bottom.equalTo(self.detailLabel.mas_bottom).offset(-15);
//        }];
    }
    return self;
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
        title.font = [UIFont boldSystemFontOfSize:18];
        title.numberOfLines  = 0;
        title.lineBreakMode = NSLineBreakByWordWrapping;
        title.textColor = [UIColor blackColor];
        [self.contentView addSubview:title];
        _titleLabel = title;
    }
    return _titleLabel;
}
- (UILabel *)markLabel{
    if (!_markLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = [UIFont boldSystemFontOfSize:20];
        title.backgroundColor = ThemeColor;
        title.numberOfLines  = 1;
        title.textAlignment = NSTextAlignmentCenter;
        title.lineBreakMode = NSLineBreakByWordWrapping;
        title.textColor = [UIColor blackColor];
        [self.contentView addSubview:title];
        _markLabel = title;
    }
    return _markLabel;
}
- (UILabel *)detailLabel{
    if (!_detailLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = [UIFont boldSystemFontOfSize:18];
        title.numberOfLines  = 0;
        title.lineBreakMode = NSLineBreakByWordWrapping;
        title.textColor = [UIColor clearColor];
        [self.contentView addSubview:title];
        _detailLabel = title;
    }
    return _detailLabel;
}


@end
