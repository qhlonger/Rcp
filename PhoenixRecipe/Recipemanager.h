//
//  Recipemanager.h
//  PhoenixRecipe
//
//  Created by Apple on 2017/12/1.
//  Copyright © 2017年 mini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecipeCategory.h"





@interface Recipemanager : NSObject
@property(nonatomic, strong) NSArray<RecipeCategoryResult *> * recipes;

+ (instancetype)manager;
+ (void)getRecipes:(void(^)(NSArray <RecipeCategoryResult *>*recipes))callback;


@end
