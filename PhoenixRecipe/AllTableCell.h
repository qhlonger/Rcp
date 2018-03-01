//
//  AllTableCell.h
//  PhoenixRecipe
//
//  Created by mini on 2017/11/23.
//  Copyright © 2017年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeCategory.h"

@interface AllTableCell : UITableViewCell

@property(nonatomic, weak) UILabel *titleLabel;

@property(nonatomic, weak) UICollectionView *collectionView;

@property(nonatomic, strong) NSArray <RecipeCategory *>*dataArray;

@property(nonatomic, copy) void(^scrollViewScroll) (UIScrollView *scrollView);

@property(nonatomic, copy) void(^collectionViewSelectAtIndexPath) (NSIndexPath *indexPath);



@end
