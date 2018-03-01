//
//  RecommendColCell.h
//  PhoenixRecipe
//
//  Created by mini on 2017/11/23.
//  Copyright © 2017年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendColCell : UICollectionViewCell

@property(nonatomic, weak) UIImageView *iconView;
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UILabel *descLabel;
@property(nonatomic, weak) UILabel *tagLabel;
//@property(nonatomic, weak) UIVisualEffectView *blurView;
@property(nonatomic, weak) UIView *blurView;

@end
