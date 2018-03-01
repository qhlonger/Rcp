//
//  AllVC.m
//  PhoenixRecipe
//
//  Created by mini on 2017/11/23.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "AllVC.h"
#import "RecipeListVC.h"
#import "AllTableCell.h"
#import "AllSectionHeader.h"
#import "QMRightItem.h"
#import "RecipeCategory.h"
#import "CategoryListVC.h"
@interface AllVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, weak) UITableView *tableView;

@property(nonatomic, strong) NSDictionary *allResult;
@property(nonatomic, strong) NSMutableArray *offsets;

@property(nonatomic, strong) NSArray *allDatas;


@property(nonatomic, strong) NSArray <RecipeCategoryResult *>*dataArray;
@property(nonatomic, weak) UIRefreshControl *refreshControl;
@end

@implementation AllVC
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[Recipemanager manager] addObserver:self forKeyPath:@"recipes" options:NSKeyValueObservingOptionNew context:nil];
    
//    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"all" ofType:@"json"];
//    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
//    NSError *error = nil;
//    self.allDatas = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
//    [self.tableView reloadData];
    [self refreshControl];
    [self refresh];
    [self setNav];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    self.dataArray = [Recipemanager manager].recipes;
}
- (void)setDataArray:(NSArray<RecipeCategoryResult *> *)dataArray{
    _dataArray = dataArray;
    [self.tableView reloadData];
}
- (void)setNav{
    
    
//    [self setNavRightItem:@"全部" callback:^{
//
//    }];
    
    
    self.title = @"分类";

}
- (void)refresh{
    __weak __typeof(self)weakSelf = self;
    [Recipemanager getRecipes:^(NSArray<RecipeCategoryResult *> *recipes) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.dataArray = recipes;
        [strongSelf.refreshControl endRefreshing];
    }];
}

- (UIRefreshControl *)refreshControl{
    if (!_refreshControl) {
        UIRefreshControl *ref = [[UIRefreshControl alloc]init];
        ref.tintColor = ThemeColor;
        __weak __typeof(self)weakSelf = self;
        [ref bk_addEventHandler:^(id sender) {
            [weakSelf refresh];
        } forControlEvents:UIControlEventValueChanged];
        
        
        
        [self.tableView setValue:ref forKey:@"refreshControl"];
        _refreshControl = ref;
    }
    return _refreshControl;
}

static NSString *AllTableCellID = @"AllTableCell";
static NSString *AllSectionHeaderID = @"AllSectionHeader";
- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass:[AllTableCell class] forCellReuseIdentifier:AllTableCellID];
        [tableView registerClass:[AllSectionHeader class] forHeaderFooterViewReuseIdentifier:AllSectionHeaderID];
        tableView.tableFooterView = [UIView new];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AllSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:AllSectionHeaderID];
//    header.titleLabel.text = self.allDatas[section][@"categoryInfo"][@"name"];
    header.titleLabel.text = self.dataArray[section].name;
    __weak __typeof(self)weakSelf = self;
    [header setDidSelectAllBtn:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        CategoryListVC *vc = [[CategoryListVC alloc]init];
        vc.categoryResult = strongSelf.dataArray[section];
        [vc setSelectCategory:^(CategoryListVC *vc, RecipeCategory *category) {
            RecipeListVC *listVC = [[RecipeListVC alloc]init];
            listVC.category = category;
            listVC.categoryResult =strongSelf.dataArray[section];
            [vc.navigationController pushViewController:listVC animated:YES];
        }];
        [strongSelf.navigationController pushViewController:vc animated:YES];
    }];
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AllTableCell *cell = [tableView dequeueReusableCellWithIdentifier:AllTableCellID forIndexPath:indexPath];
//    cell.dataArray = self.allDatas[indexPath.section][@"childs"];
    cell.dataArray = self.dataArray[indexPath.section].modelList;
    __weak __typeof(self)weakSelf = self;
    [cell setScrollViewScroll:^(UIScrollView *scrollView) {
        weakSelf.offsets[indexPath.section] = @(scrollView.contentOffset.x);
    }];
    [cell.collectionView setContentOffset:CGPointMake([self.offsets[indexPath.section] floatValue], 0)];
    [cell setCollectionViewSelectAtIndexPath:^(NSIndexPath *insideIndexPath) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        RecipeListVC *vc = [[RecipeListVC alloc]init];
        vc.category = strongSelf.dataArray[indexPath.section].modelList[insideIndexPath.row];
        vc.categoryResult = strongSelf.dataArray[indexPath.section];
        [strongSelf.navigationController pushViewController:vc animated:YES];
    }];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
