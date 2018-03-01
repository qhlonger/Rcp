//
//  RecommedCell.h
//  PhoenixRecipe
//
//  Created by mini on 2017/11/23.
//  Copyright © 2017年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommedCell : UITableViewCell

@property(nonatomic, weak) UICollectionView *collectionView;

@property(nonatomic, strong) NSMutableArray <RecipeModel *>*dataArray;


@property(nonatomic, copy) void(^collectionViewSelectAtIndexPath) (NSIndexPath *indexPath);
@end
