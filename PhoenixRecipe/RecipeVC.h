//
//  RecipeVC.h
//  PhoenixRecipe
//
//  Created by mini on 2017/11/24.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "BaseVC.h"
@interface RecipeVC : BaseVC

@property(nonatomic, strong) RecipeModel *recipe;
@property(nonatomic, assign) NSNumber *recipeId;
@property(nonatomic, assign) BOOL allowRandom;
@end
