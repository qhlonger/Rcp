//
//  RecipeListColCell.h
//  PhoenixRecipe
//
//  Created by mini on 2017/11/24.
//  Copyright © 2017年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeListColCell : UICollectionViewCell

@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UIImageView *iconView;

@property(nonatomic, weak) UILabel *descLabel;

@property(nonatomic, weak) UIView *line;

@property(nonatomic, weak) UIView *bgView;
@end
