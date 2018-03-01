//
//  HomeColCell.h
//  PhoenixRecipe
//
//  Created by Apple on 2017/12/1.
//  Copyright © 2017年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeColCell : UICollectionViewCell
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UIImageView  *iconView;
@property(nonatomic, weak) UILabel *descLabel;

@property(nonatomic, weak) UIVisualEffectView *blurView;

@end
