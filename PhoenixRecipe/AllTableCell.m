//
//  AllTableCell.m
//  PhoenixRecipe
//
//  Created by mini on 2017/11/23.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "AllTableCell.h"
#import "AllColCell.h"
@interface AllTableCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    
}


@end
@implementation AllTableCell

- (void)setDataArray:(NSArray *)dataArray{
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


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = [UIFont boldSystemFontOfSize:18];
        title.textColor = [UIColor blackColor];
        [self.contentView addSubview:title];
        _titleLabel = title;
    }
    return _titleLabel;
}

static NSString *AllColCellID = @"AllColCell";
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
        
        [collectionView registerClass:[AllColCell class] forCellWithReuseIdentifier:AllColCellID];
        [self.contentView addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //    return self.dataArray.count;
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AllColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AllColCellID forIndexPath:indexPath];
//    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:@"http://f2.mob.com/null/2015/08/18/1439876711867.jpg"] placeholderImage:[UIImage imageWithColor:RGBA(240, 240, 240, 1)] ];
//    cell.titleLabel.text = self.dataArray[indexPath.row][@"categoryInfo"][@"name"];
    cell.titleLabel.text = self.dataArray[indexPath.row].name;
    cell.bgTextLabel.text = self.dataArray[indexPath.row].name;
    cell.iconView.backgroundColor = self.dataArray[indexPath.row].color;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.collectionView.frame.size.height * 1.4, self.collectionView.frame.size.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.scrollViewScroll)self.scrollViewScroll(scrollView);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.collectionViewSelectAtIndexPath)self.collectionViewSelectAtIndexPath(indexPath);
}
@end
