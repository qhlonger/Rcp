//
//  RecipeListVC.h
//  PhoenixRecipe
//
//  Created by mini on 2017/11/24.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "BaseVC.h"

#import "RecipeCategory.h"
@interface RecipeListVC : BaseVC

@property(nonatomic, strong) RecipeCategory *category;
@property(nonatomic, strong) RecipeCategoryResult *categoryResult;
@end
