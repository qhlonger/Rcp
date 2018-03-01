//
//  RecipeListVC.m
//  PhoenixRecipe
//
//  Created by mini on 2017/11/24.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "RecipeListVC.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "RecipeListColCell.h"
#import "CategoryListVC.h"
#import "RecipeListColHeaderCell.h"
#import "RecipeVC.h"
#import "MJRefresh.h"
@interface RecipeListVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CHTCollectionViewDelegateWaterfallLayout>
@property(nonatomic, weak) UICollectionView *collectionView;
@property(nonatomic, weak) UIRefreshControl *refreshControl;
@property(nonatomic, strong) NSMutableArray <RecipeModel*>*dataArray;
@property(nonatomic, assign) NSInteger page;

@end

@implementation RecipeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [@[] mutableCopy];
    
    [self refreshControl];
//    [self collectionView];
    
    NSMutableArray *vcs = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if([vc isKindOfClass:[CategoryListVC class]]){
            [vcs removeObject:vc];
        }
    }
    self.navigationController.viewControllers = vcs;
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)getDataBy:(NSInteger)page{
    __weak __typeof(self)weakSelf = self;
    [HttpManager getWithPath:[NSString stringWithFormat:@"%@%@",RecipePath,@"recipe/byclass"] param:@{@"classid":self.category.classid,@"start":@(page*20),@"num":@20} showProgress:page == 0 showMsg:NO success:^(NSURLSessionDataTask *task, id data) {
        
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.refreshControl endRefreshing];
        [strongSelf.collectionView.mj_footer endRefreshing];
        NSArray *array = [RecipeModel mj_objectArrayWithKeyValuesArray:data[@"list"]];
        if(page == 0){
            strongSelf.dataArray =[NSMutableArray arrayWithArray:array];
            MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [strongSelf getDataBy:strongSelf.page];
            }];
            footer.refreshingTitleHidden = YES;
            footer.automaticallyHidden = YES;
            strongSelf.collectionView.mj_footer = footer;
            if(array.count < 20){
                strongSelf.collectionView.mj_footer.hidden = YES;
                strongSelf.collectionView.mj_footer = nil;
            }
        }else{
            [strongSelf.dataArray addObjectsFromArray:array];
            if(array.count < 20){
                [strongSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
                
            }
        }
        
        
        strongSelf.page = page+1;
        [strongSelf.collectionView reloadData];
    } failure:^{
        [self.refreshControl endRefreshing];
        
        self.collectionView.mj_footer.hidden = YES;
        self.collectionView.mj_footer = nil;
        
    }];
}


- (UIRefreshControl *)refreshControl{
    if (!_refreshControl) {
        UIRefreshControl *ref = [[UIRefreshControl alloc]init];
        ref.tintColor = ThemeColor;
        
        [ref bk_addEventHandler:^(id sender) {
            [self getDataBy:0];
        } forControlEvents:UIControlEventValueChanged];
        
        
        self.collectionView.refreshControl = ref;
        _refreshControl = ref;
    }
    return _refreshControl;
}


- (void)setCategory:(RecipeCategory *)category{
    _category = category;
    self.title = category.name;
    [self getDataBy:0];
    
}
- (void)setCategoryResult:(RecipeCategoryResult *)categoryResult{
    _categoryResult = categoryResult;
    __weak __typeof(self)weakSelf = self;
    [self setNavRightItem:categoryResult.name callback:^{
        CategoryListVC *vc= [[CategoryListVC alloc]init];
        vc.categoryResult = weakSelf.categoryResult;
        vc.category = weakSelf.category;
        [vc setSelectCategory:^(CategoryListVC *vc, RecipeCategory *category) {
            [vc.navigationController popViewControllerAnimated:YES];
            weakSelf.category = category;
        }];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
}

static NSString *RecipeListColCellID = @"RecipeListColCell";
static NSString *RecipeListColHeaderCellID = @"RecipeListColHeaderCell";
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        CHTCollectionViewWaterfallLayout *flowLayout = [[CHTCollectionViewWaterfallLayout alloc]init];
//        flowLayout.minimumColumnSpacing = 10;
//        flowLayout.minimumInteritemSpacing = 10;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
//        collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
        collectionView.backgroundColor = RGBA(240, 240, 240, 1);
        [collectionView registerClass:[RecipeListColCell class] forCellWithReuseIdentifier:RecipeListColCellID];
        [collectionView registerClass:[RecipeListColHeaderCell class] forCellWithReuseIdentifier:RecipeListColHeaderCellID];
        [collectionView emptyViewConfigerBlock:^(FOREmptyAssistantConfiger *configer) {
            
            configer.emptyImage = [UIImage imageNamed:@"placeholder"];
            configer.emptySubtitle = @"这里什么都没有";
//            configer.emptyCenterOffset = CGPointMake(0, -100);
        }];
        
        [self.view addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        RecipeListColHeaderCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:RecipeListColHeaderCellID forIndexPath:indexPath];
        [cell.iconView sd_setImageWithURL:[NSURL URLWithString:self.dataArray[indexPath.row].pic] placeholderImage:[UIImage imageWithColor:RGBA(240, 240, 240, 1)] ];
        cell.titleLabel.text = self.dataArray[indexPath.row].name;
        return cell;
    }
    
    
    RecipeListColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RecipeListColCellID forIndexPath:indexPath];
    
    
     [cell.iconView sd_setImageWithURL:[NSURL URLWithString:self.dataArray[indexPath.row].pic] placeholderImage:[UIImage imageWithColor:RGBA(240, 240, 240, 1)] ];
    
    cell.titleLabel.text = self.dataArray[indexPath.row].name;
    cell.descLabel.text = self.dataArray[indexPath.row].tag;
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat w = (CGRectGetWidth(self.view.frame) )/2;
    
    if(indexPath.row == 0){
        return CGSizeMake(w, w*0.75);
    }else{
        return CGSizeMake(w, w*1.5);
    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    RecipeVC *vc = [[RecipeVC alloc]init];
    vc.recipe = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
