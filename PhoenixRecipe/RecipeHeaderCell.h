//
//  RecipeHeaderCell.h
//  PhoenixRecipe
//
//  Created by mini on 2017/11/24.
//  Copyright © 2017年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeHeaderCell : UITableViewCell

@property(nonatomic, weak) UIImageView *iconView;
@property(nonatomic, weak) UILabel *peopleLabel;
@property(nonatomic, weak) UILabel *pTimeLabel;
@property(nonatomic, weak) UILabel *cTimeLabel;
@property(nonatomic, weak) UILabel *tagLabel;
@property(nonatomic, weak) UILabel *descLabel;


@end
