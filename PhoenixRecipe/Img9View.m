//
//  Img9View.m
//  PhoenixRecipe
//
//  Created by Apple on 2018/2/1.
//  Copyright © 2018年 mini. All rights reserved.
//

#import "Img9View.h"

@implementation Img9View


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addImg];
    }
    return self;
}
- (void)addImg{
    NSMutableArray <UIImageView*>*a = [@[] mutableCopy];
    for (int i = 0; i < 9; i ++) {
        UIImageView *img = [[UIImageView alloc]init];
        img.layer.cornerRadius = 20;
        img.clipsToBounds = YES;
        img.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        img.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:img];
        [a addObject:img];
    }
    self.imageViews = a;
}
- (void)layoutSubviews{
    CGFloat p = 10;
    CGFloat w = (CGRectGetWidth(self.frame) - p * 4) / 3;
    
    int i = 0;
    for (UIImageView *img in self.imageViews) {
        CGFloat row = i / 3;
        CGFloat col = i % 3;
        img.frame = CGRectMake( col * (p+w), row * (p+w) , w, w);
        i++;
    }
}
- (void)setImgs:(NSArray<NSString *> *)imgs{
    _imgs = imgs;
    for (int i = 0; i < self.imageViews.count; i++) {
        [self.imageViews[i] sd_setImageWithURL:[NSURL URLWithString: imgs[i]]];
    }
}
- (void)setRecipes:(NSArray<RecipeModel *> *)recipes{
    _recipes = recipes;
    for (int i = 0; i < self.imageViews.count; i++) {
        if(i < recipes.count -1){
            [self.imageViews[i] sd_setImageWithURL:[NSURL URLWithString: recipes[i].pic]];
        }
    }
    
}
@end
