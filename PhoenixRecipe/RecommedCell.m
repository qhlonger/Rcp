
//
//  RecommedCell.m
//  PhoenixRecipe
//
//  Created by mini on 2017/11/23.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "RecommedCell.h"
#import "RecommendColCell.h"
#import "Img9RecommendColCell.h"
#import "RecommendModel.h"

@interface RecommedCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    
}

@end
@implementation RecommedCell


- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(0);
        }];
        //        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(self.contentView).offset(15);
        //            make.top.equalTo(self.contentView);
        //            make.height.mas_equalTo(40);
        //            make.width.lessThanOrEqualTo(self.contentView.mas_width).multipliedBy(0.6);
        //        }];
        
        
        
    }
    return self;
}


//- (UILabel *)titleLabel{
//    if (!_titleLabel) {
//        UILabel *title = [[UILabel alloc]init];
//        title.font = [UIFont boldSystemFontOfSize:18];
//        title.textColor = [UIColor blackColor];
//        [self.contentView addSubview:title];
//        _titleLabel = title;
//    }
//    return _titleLabel;
//}

static NSString *RecommendColCellID = @"RecommendColCell";
static NSString *Img9RecommendColCellID = @"Img9RecommendColCell";
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        
        [collectionView registerClass:[RecommendColCell class] forCellWithReuseIdentifier:RecommendColCellID];
        [collectionView registerClass:[Img9RecommendColCell class] forCellWithReuseIdentifier:Img9RecommendColCellID];
        [self.contentView addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
//    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id model = self.dataArray[indexPath.row];
    
    if([model isKindOfClass:[RecommendModel class]]){
        RecommendModel *md = (RecommendModel *)model;
        
        Img9RecommendColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Img9RecommendColCellID forIndexPath:indexPath];
        cell.iconView.recipes = md.recipes;
        cell.titleLabel.text = md.title;
        cell.tagLabel.text = md.detail;
        return cell;
    }else{
        RecipeModel *md = (RecipeModel *)model;
        
        
        RecommendColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RecommendColCellID forIndexPath:indexPath];
        
        [cell.iconView sd_setImageWithURL:[NSURL URLWithString:md.pic] placeholderImage:[UIImage imageWithColor:RGBA(240, 240, 240, 1)] ];
        cell.titleLabel.text = md.name;
        cell.descLabel.text = md.content;
        cell.tagLabel.text = md.tag;
        return cell;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.collectionView.frame.size.height * 1, self.collectionView.frame.size.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if(self.scrollViewScroll)self.scrollViewScroll(scrollView);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.collectionViewSelectAtIndexPath)self.collectionViewSelectAtIndexPath(indexPath);
}


@end

