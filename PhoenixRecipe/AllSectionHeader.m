//
//  AllSectionHeader.m
//  PhoenixRecipe
//
//  Created by mini on 2017/11/23.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "AllSectionHeader.h"

@implementation AllSectionHeader

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.bottom.equalTo(self.contentView);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.6);
    }];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(35);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.moreBtn.mas_left).offset(-10);
        make.left.equalTo(self.titleLabel);
    }];
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
- (UILabel *)detailLabel{
    if (!_detailLabel) {
        UILabel *detail = [[UILabel alloc]init];
        detail.font = [UIFont boldSystemFontOfSize:14];
        detail.textColor = [UIColor lightGrayColor];
        detail.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:detail];
        _detailLabel = detail;
    }
    return _detailLabel;
}
- (UIButton *)moreBtn{
    if (!_moreBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[[UIImage imageNamed:@"more"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        btn.tintColor = ThemeColor;
        __weak __typeof(self)weakSelf = self;
        [btn bk_addEventHandler:^(id sender) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if(strongSelf.didSelectAllBtn)strongSelf.didSelectAllBtn();
        } forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        _moreBtn = btn;
    }
    return _moreBtn;
}


@end
