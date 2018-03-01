//
//  Img9RecommendColCell.h
//  PhoenixRecipe
//
//  Created by Apple on 2018/2/1.
//  Copyright © 2018年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Img9View.h"
@interface Img9RecommendColCell : UICollectionViewCell
@property(nonatomic, weak) UIView *imgBgView;
@property(nonatomic, weak) Img9View *iconView;
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UILabel *descLabel;
@property(nonatomic, weak) UILabel *tagLabel;
@property(nonatomic, weak) UIVisualEffectView *blurView;
@end
