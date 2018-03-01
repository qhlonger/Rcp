//
//  RecipeMaterialCell.m
//  PhoenixRecipe
//
//  Created by mini on 2017/11/24.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "RecipeMaterialCell.h"

@implementation RecipeMaterialCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.top.bottom.equalTo(self.contentView);
            make.width.equalTo(self.contentView).multipliedBy(0.8);
        }];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.top.bottom.equalTo(self.contentView);
            make.width.equalTo(self.contentView).multipliedBy(0.8);
        }];
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = [UIFont boldSystemFontOfSize:16];
        title.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:title];
        _titleLabel = title;
    }
    return _titleLabel;
}
- (UILabel *)detailLabel{
    if (!_detailLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = [UIFont systemFontOfSize:16];
        title.textColor = [UIColor blackColor];
        title.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:title];
        _detailLabel = title;
    }
    return _detailLabel;
}



@end
