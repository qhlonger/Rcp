//
//  RecipeListColHeaderCell.m
//  PhoenixRecipe
//
//  Created by mini on 2017/11/24.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "RecipeListColHeaderCell.h"

@implementation RecipeListColHeaderCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-5);
            make.left.equalTo(self.contentView).offset(5);
            make.top.equalTo(self.contentView).offset(5);
            make.bottom.equalTo(self.contentView).offset(-5);
            
        }];
        
        
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-5);
            make.left.equalTo(self.contentView).offset(5);
            make.bottom.equalTo(self.contentView).offset(-5);
            make.height.mas_equalTo(30);
            
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
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.textAlignment = NSTextAlignmentLeft;
        title.backgroundColor = RGBA(255, 255, 255, 0.8);
        title.font = [UIFont boldSystemFontOfSize:18];
        title.textColor = [UIColor blackColor];
        [self.contentView addSubview:title];
        _titleLabel = title;
    }
    return _titleLabel;
}

@end
