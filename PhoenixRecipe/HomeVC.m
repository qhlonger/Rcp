//
//  HomeVC.m
//  PhoenixRecipe
//
//  Created by mini on 2017/11/23.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "HomeVC.h"
#import "HomeCell.h"
#import "RecommedCell.h"
#import "QMRightItem.h"
#import "RecipeVC.h"
#import "AllSectionHeader.h"
#import "HomeHorScrollCell.h"
#import "RecommendModel.h"
#import <BmobSDK/Bmob.h>
#import <Social/Social.h>
#import "RecpieListVC.h"
@interface HomeVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, weak) UIRefreshControl *refreshControl;
@property(nonatomic, strong) NSMutableArray *recoommands;
@property(nonatomic, strong) NSMutableArray *lunchs;
@property(nonatomic, strong) NSMutableArray *snacks;


@end

@implementation HomeVC
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
    self.title = @"推荐";
    __weak __typeof(self)weakSelf = self;
    [Recipemanager getRecipes:^(NSArray<RecipeCategoryResult *> *recipes) {
//        [weakSelf.tableView reloadData];
//        [weakSelf.refreshControl endRefreshing];
    }];
    
    
    [self setNav];
    [self tableView];
    [self refreshControl];
    
    [self getAllData:YES];
    
//    [self getRandomSnacks];
//    [self getRandomLunch];
}
- (void)setNav{
    __weak __typeof(self)weakSelf = self;
    [self setNavRightItem:@"随便看看" callback:^{
        
        
        
        
        
      
        
        
        
        
        
        
        
        
        RecipeVC *recipeVC = [[RecipeVC alloc]init];
        [weakSelf.navigationController pushViewController:recipeVC animated:YES];
    }];
    
    
    
    
}

- (void)getAllData:(BOOL)show{
    if(show)
        [self.view startLoading];
    NSArray *arrs = [Util getRandomLaunchId:4];
    
    dispatch_group_t dispatchGroup = dispatch_group_create();
    
    
    dispatch_group_enter(dispatchGroup);
    NSMutableArray *recoommands = [@[] mutableCopy];
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"rmd"];
    //查找GameScore表的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        
        RecommendModel *model9V = [[RecommendModel alloc]init];
        model9V.title = @"好吃好玩";
        model9V.detail = @"🍳烹饪也好玩🎉";
        [recoommands addObject:model9V];
        
        NSMutableArray *md9vr = [@[] mutableCopy];
        for (BmobObject *obj in array) {
            RecipeModel *mod = [[RecipeModel alloc]init];
            
            mod.name = [obj objectForKey:@"name"];
            mod.pic = [obj objectForKey:@"pic"];
            mod.tag = [obj objectForKey:@"tag"];
            mod.content = [obj objectForKey:@"content"];
            mod.id = @([[obj objectForKey:@"id"] integerValue]);
            NSString *type = [obj objectForKey:@"type"];
            if([type isEqualToString:@"0"]){
                [recoommands addObject:mod];
            }else if([type isEqualToString:@"1"]){
                [md9vr addObject:mod];
                //            }else if([type isEqualToString:@"1"]){
                
            }
        }
        ((RecommendModel *)recoommands[0]).recipes = md9vr;
        
        NSLog(@"bmob请求%d成功");
        dispatch_group_leave(dispatchGroup);
        
    }];
    
    
    
    NSMutableArray *lunchs = [@[] mutableCopy];
    for (int i = 0 ; i < arrs.count; i++) {
        dispatch_group_enter(dispatchGroup);
        NSLog(@"开始请求%d",i);
        [HttpManager getWithPath:[NSString stringWithFormat:@"%@%@",RecipePath,@"recipe/detail"] param:@{@"id":arrs[i]}
                    showProgress:NO
                         showMsg:NO
                         success:^(NSURLSessionDataTask *task, id data) {
            RecipeModel *model = [RecipeModel mj_objectWithKeyValues:data];
            if(model){
                [lunchs addObject:  model];
            }
            NSLog(@"请求%d成功",i);
            dispatch_group_leave(dispatchGroup);
        } failure:^{
            NSLog(@"请求%d失败",i);
            dispatch_group_leave(dispatchGroup);
            
        }];
    }
    
        NSArray *arrsn = [Util getSnacksId:4];
        NSMutableArray *snacks = [@[] mutableCopy];
        for (int i = 0 ; i < arrsn.count; i++) {
            dispatch_group_enter(dispatchGroup);
            NSLog(@"开始请求小吃%d",i);
            [HttpManager getWithPath:[NSString stringWithFormat:@"%@%@",RecipePath,@"recipe/detail"] param:@{@"id":arrsn[i]} showProgress:NO showMsg:NO success:^(NSURLSessionDataTask *task, id data) {
                RecipeModel *model = [RecipeModel mj_objectWithKeyValues:data];
                if(model){
                    [snacks addObject:  model];
                }
                NSLog(@"请求小吃%d成功",i);
                dispatch_group_leave(dispatchGroup);
            } failure:^{
                NSLog(@"请求小吃%d失败",i);
                dispatch_group_leave(dispatchGroup);
    
            }];
        }
    
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        
        self.lunchs = lunchs;
        self.snacks = snacks;
        self.recoommands = recoommands;
        
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
        [self.view stopLoading];
        NSLog(@"重载列表");
    });
    

    
    
    
}
- (void)getRandomSnacks{
    
    dispatch_group_t dispatchGroup = dispatch_group_create();
    
    [self.view startLoading];
    NSArray *arrs = [Util getSnacksId:4];
    NSMutableArray  *snacks = [@[] mutableCopy];
    for (int i = 0 ; i < arrs.count; i++) {
        dispatch_group_enter(dispatchGroup);
        [HttpManager getWithPath:[NSString stringWithFormat:@"%@%@",RecipePath,@"recipe/detail"] param:@{@"id":arrs[i]} showProgress:NO showMsg:NO success:^(NSURLSessionDataTask *task, id data) {
            RecipeModel *model = [RecipeModel mj_objectWithKeyValues:data];
            if(model){
                [snacks addObject:  model];
            }
            dispatch_group_leave(dispatchGroup);
        } failure:^{
            dispatch_group_leave(dispatchGroup);
        }];
    }
    
    
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        self.snacks = snacks;
        [self.tableView reloadData];
        
        [self.view stopLoading];
        NSLog(@"重载列表");
    });
}

- (void)getRandomLunch{
    [self.view startLoading];
    dispatch_group_t dispatchGroup = dispatch_group_create();
    
    NSArray *arrs = [Util getRandomLaunchId:4];
    NSMutableArray *lunchs = [@[] mutableCopy];
    
    for (int i = 0 ; i < arrs.count; i++) {
        dispatch_group_enter(dispatchGroup);
        [HttpManager getWithPath:[NSString stringWithFormat:@"%@%@",RecipePath,@"recipe/detail"] param:@{@"id":arrs[i]} showProgress:NO showMsg:NO success:^(NSURLSessionDataTask *task, id data) {
            RecipeModel *model = [RecipeModel mj_objectWithKeyValues:data];
            if(model){
                [lunchs addObject:  model];
            }
            
            dispatch_group_leave(dispatchGroup);
        } failure:^{
            
            dispatch_group_leave(dispatchGroup);
            
        }];
    }
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        self.lunchs = lunchs;
        [self.tableView reloadData];

        [self.view stopLoading];
        NSLog(@"重载列表");
    });
}















- (UIRefreshControl *)refreshControl{
    if (!_refreshControl) {
        UIRefreshControl *ref = [[UIRefreshControl alloc]init];
        ref.tintColor = ThemeColor;
        
        [ref bk_addEventHandler:^(id sender) {
            [self getAllData:NO];
        } forControlEvents:UIControlEventValueChanged];
        
        
        [self.tableView setValue:ref forKey:@"refreshControl"];
        _refreshControl = ref;
    }
    return _refreshControl;
}










static NSString *HomeCellID = @"HomeCell";
static NSString *RecommedCellID = @"RecommedCell";
static NSString *AllSectionHeaderID = @"AllSectionHeader";
static NSString *HomeHorScrollCellID = @"HomeHorScrollCell";
- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass:[HomeCell class] forCellReuseIdentifier:HomeCellID];
        [tableView registerClass:[RecommedCell class] forCellReuseIdentifier:RecommedCellID];
        [tableView registerClass:[AllSectionHeader class] forHeaderFooterViewReuseIdentifier:AllSectionHeaderID];
        [tableView registerClass:[HomeHorScrollCell class] forCellReuseIdentifier:HomeHorScrollCellID];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3    ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0){
        return 320;
    }else if(indexPath.section == 1){
        return 200;
    }else if(indexPath.section == 2){
        return 200;
    }
    
    return 45;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AllSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:AllSectionHeaderID];
    //    header.titleLabel.text = self.allDatas[section][@"categoryInfo"][@"name"];
//    header.titleLabel.text = self.dataArray[section].name;
    
    
    [header.moreBtn setImage:[[UIImage imageNamed:@"random"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    __weak __typeof(self)weakSelf = self;
    if(section == 1){
        header.titleLabel.text = @"今日午餐";
        header.detailLabel.text = @"午餐，吃顿好的";
        [header setDidSelectAllBtn:^{
            [weakSelf getRandomLunch];
        }];
//    }else if(section == 2){
//        header.titleLabel.text = @"";
    }else if(section == 2){
        [header setDidSelectAllBtn:^{
            [weakSelf getRandomSnacks];
        }];
        header.titleLabel.text = @"吃遍中国";
        header.detailLabel.text = @"足不出户，吃遍全国小吃";
    }
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 0 : 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak __typeof(self)weakSelf = self;
    if(indexPath.section == 0){
        RecommedCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommedCellID forIndexPath:indexPath];
        cell.dataArray = self.recoommands;
        
        [cell setCollectionViewSelectAtIndexPath:^(NSIndexPath *idxPath) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            id model = strongSelf.recoommands[idxPath.row];
            
            if([model isKindOfClass:[RecommendModel class]]){
                RecommendModel *md = (RecommendModel *)model;
                
                
                RecpieListVC *recVC = [[RecpieListVC alloc]init];
                recVC.dataArray = md.recipes;
                recVC.title = md.title;
                [strongSelf.navigationController pushViewController:recVC animated:YES];
            }else{
                RecipeModel *md = (RecipeModel *)model;
                RecipeVC *recVC = [[RecipeVC alloc]init];
                recVC.recipe = md;
                [strongSelf.navigationController pushViewController:recVC animated:YES];
                
            }
            
        }];
        return cell;
    }else{
        HomeHorScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeHorScrollCellID forIndexPath:indexPath];
        
        
        //563
        if(indexPath.section == 1){
            cell.dataArray = self.lunchs;
            [cell setCollectionViewSelectAtIndexPath:^(NSIndexPath *idxPath) {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                RecipeVC *recVC = [[RecipeVC alloc]init];
                
                recVC.recipe = strongSelf.lunchs[idxPath.row];
                [strongSelf.navigationController pushViewController:recVC animated:YES];
            }];
        }else{
            cell.dataArray = self.snacks;
            [cell setCollectionViewSelectAtIndexPath:^(NSIndexPath *idxPath) {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                RecipeVC *recVC = [[RecipeVC alloc]init];
                recVC.recipe = strongSelf.snacks[idxPath.row];
                
                [strongSelf.navigationController pushViewController:recVC animated:YES];
            }];
            
        }
        return cell;
    }
    
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeCellID forIndexPath:indexPath];
    
    return cell;
}

@end
