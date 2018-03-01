//
//  RecipeCategory.h
//  PhoenixRecipe
//
//  Created by mini on 2017/11/24.
//  Copyright © 2017年 mini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecipeCategory : NSObject

@property(nonatomic, assign) NSNumber *classid;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) NSNumber *parentid;

@property(nonatomic, strong) UIColor *color;
@end

@interface RecipeCategoryResult : NSObject

@property(nonatomic, assign) NSNumber *classid;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) NSNumber *parentid;
@property(nonatomic, strong) NSArray *list;
@property(nonatomic, strong) NSArray <RecipeCategory*>*modelList;

@end


