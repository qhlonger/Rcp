//
//  RecipeHeaderCell.m
//  PhoenixRecipe
//
//  Created by mini on 2017/11/24.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "RecipeHeaderCell.h"

@implementation RecipeHeaderCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(140);
            make.top.left.equalTo(self.contentView).offset(15);
        }];
        [self.pTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_right).offset(15);
            make.top.equalTo(self.iconView);
            make.right.equalTo(self.contentView).offset(-15);
            make.height.equalTo(self.iconView.mas_height).multipliedBy(0.33);
        }];
        [self.cTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.iconView.mas_right).offset(15);
            make.top.equalTo(self.pTimeLabel.mas_bottom);
            make.right.equalTo(self.contentView).offset(-15);
            make.height.equalTo(self.iconView.mas_height).multipliedBy(0.33);
        }];
        [self.peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.iconView.mas_right).offset(15);
            make.top.equalTo(self.cTimeLabel.mas_bottom);
            make.right.equalTo(self.contentView).offset(-15);
            make.height.equalTo(self.iconView.mas_height).multipliedBy(0.33);
        }];
        
        [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(15);
            make.top.equalTo(self.iconView.mas_bottom).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            
        }];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(15);
            make.top.equalTo(self.tagLabel.mas_bottom).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.bottom.equalTo(self.contentView).offset(-15);
        }];
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

- (UILabel *)descLabel{
    if (!_descLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = [UIFont boldSystemFontOfSize:16];
        title.numberOfLines = 0;
        title.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:title];
        _descLabel = title;
    }
    return _descLabel;
}
- (UILabel *)tagLabel{
    if (!_tagLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = [UIFont boldSystemFontOfSize:16];
        title.numberOfLines = 0;
        title.textColor = ThemeColor;
        [self.contentView addSubview:title];
        _tagLabel = title;
    }
    return _tagLabel;
}
- (UILabel *)peopleLabel{
    if (!_peopleLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = [UIFont boldSystemFontOfSize:16];
        title.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:title];
        _peopleLabel = title;
    }
    return _peopleLabel;
}
- (UILabel *)pTimeLabel{
    if (!_pTimeLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = [UIFont boldSystemFontOfSize:16];
        title.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:title];
        _pTimeLabel = title;
    }
    return _pTimeLabel;
}
- (UILabel *)cTimeLabel{
    if (!_cTimeLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = [UIFont boldSystemFontOfSize:16];
        title.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:title];
        _cTimeLabel = title;
    }
    return _cTimeLabel;
}


@end
