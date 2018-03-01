//
//  RecipeListTabCell.h
//  PhoenixRecipe
//
//  Created by Apple on 2017/12/2.
//  Copyright © 2017年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeListTabCell : UITableViewCell


@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UILabel *descLabel;
@property(nonatomic, weak) UIImageView *iconView;
@property(nonatomic, weak) UILabel *tagLabel;

@property(nonatomic, strong) RecipeModel  *recipe;
@end
