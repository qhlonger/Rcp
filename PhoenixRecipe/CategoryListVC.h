//
//  CategoryListVC.h
//  PhoenixRecipe
//
//  Created by mini on 2017/11/24.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "BaseVC.h"
#import "RecipeCategory.h"
@interface CategoryListVC : BaseVC
@property(nonatomic, strong) RecipeCategoryResult *categoryResult;
@property(nonatomic, strong) RecipeCategory *category;

@property(nonatomic, copy) void(^selectCategory)(CategoryListVC *vc,RecipeCategory*category);

@end
