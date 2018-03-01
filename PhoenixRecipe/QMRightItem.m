//
//  QMRightItem.m
//  ChongQingMovie
//
//  Created by mini on 2017/11/23.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "QMRightItem.h"


@implementation QMRightItem


- (UIButton *)btn{
    if (!_btn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        btn.tintColor = ThemeColor;
        [self addSubview:btn];
        _btn = btn;
    }
    return _btn;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat h = CGRectGetHeight(self.frame);
    
    self.btn.frame = self.bounds;
//    if (@available(iOS 11, *)) {
//        self.btn.frame = CGRectMake(w - h, 0, h, h);
//    }else{
//        self.btn.frame = self.bounds;
//    }
    
}


@end
