//
//  RecipeListTabCell.m
//  PhoenixRecipe
//
//  Created by Apple on 2017/12/2.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "RecipeListTabCell.h"

@implementation RecipeListTabCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(15);
            make.bottom.equalTo(self.contentView).offset(-15);
            make.width.equalTo(self.iconView.mas_height);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconView);
            make.left.equalTo(self.iconView.mas_right).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.height.equalTo(self.iconView).multipliedBy(0.3);
        }];
        [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom);
            make.left.equalTo(self.iconView.mas_right).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.height.equalTo(self.iconView).multipliedBy(0.2);
        }];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tagLabel.mas_bottom);
            make.left.equalTo(self.iconView.mas_right).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.height.equalTo(self.iconView).multipliedBy(0.5);
        }];
        
    }
    return self;
}



- (void)setRecipe:(RecipeModel *)recipe{
    _recipe = recipe;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:recipe.pic] placeholderImage:[UIImage imageWithColor:RGBA(240, 240, 240, 1)]];
    self.titleLabel.text = recipe.name;
    self.descLabel.text = recipe.content;
    self.tagLabel.text = recipe.tag;
}



- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = [UIFont boldSystemFontOfSize:24];
        title.textColor = [UIColor blackColor];
        [self.contentView addSubview:title];
        _titleLabel = title;
    }
    return _titleLabel;
}
- (UILabel *)descLabel{
    if (!_descLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = [UIFont systemFontOfSize:14];
        title.textColor = [UIColor grayColor];
        title.numberOfLines = 0;
        title.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:title];
        _descLabel = title;
    }
    return _descLabel;
}
- (UILabel *)tagLabel{
    if (!_tagLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = [UIFont boldSystemFontOfSize:18];
        title.textColor = ThemeColor;
        [self.contentView addSubview:title];
        _tagLabel = title;
    }
    return _tagLabel;
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



@end
