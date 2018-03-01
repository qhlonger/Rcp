//
//  RecommendModel.h
//  PhoenixRecipe
//
//  Created by Apple on 2018/2/1.
//  Copyright © 2018年 mini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecipeModel.h"
@interface RecommendModel : NSObject

@property(nonatomic, strong) NSArray <RecipeModel *>*recipes;

@property(nonatomic, assign) NSString *title;
@property(nonatomic, strong) NSString *detail;

@end
