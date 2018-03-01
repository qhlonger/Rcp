//
//  HomeHorScrollCell.h
//  PhoenixRecipe
//
//  Created by Apple on 2017/12/1.
//  Copyright © 2017年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeHorScrollCell : UITableViewCell


@property(nonatomic, weak) UILabel *titleLabel;

@property(nonatomic, weak) UICollectionView *collectionView;


@property(nonatomic, strong) NSMutableArray <RecipeModel *>*dataArray;

@property(nonatomic, copy) void(^scrollViewScroll) (UIScrollView *scrollView);

@property(nonatomic, copy) void(^collectionViewSelectAtIndexPath) (NSIndexPath *indexPath);

@property(nonatomic, assign) BOOL is9View;
@end
