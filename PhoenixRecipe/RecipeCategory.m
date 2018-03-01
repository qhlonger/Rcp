
//
//  RecipeCategory.m
//  PhoenixRecipe
//
//  Created by mini on 2017/11/24.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "RecipeCategory.h"

@implementation RecipeCategory

- (UIColor *)color{
    if (!_color) {
        UIColor *color = [UIColor randomColor];
        UIColor *color1 = [color flatten];
        UIColor *color2 = [color lightenByPercentage:0.6];
        NSArray *colors =@[color1,color2];
        CGRect rect = CGRectMake(0, 0, 160, 120);
        _color = GradientColor(UIGradientStyleLeftToRight, rect, colors) ;
    }
    return _color;
}
@end

@implementation RecipeCategoryResult

- (void)setList:(NSArray *)list{
    _list = list;
    self.modelList = [RecipeCategory mj_objectArrayWithKeyValuesArray:list];
}



@end

