//
//  Img9View.h
//  PhoenixRecipe
//
//  Created by Apple on 2018/2/1.
//  Copyright © 2018年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Img9View : UIView

@property(nonatomic, strong) NSArray <UIImageView *>*imageViews;
@property(nonatomic, strong) NSArray <NSString *>*imgs;
@property(nonatomic, strong) NSArray <RecipeModel *>*recipes;
@end
