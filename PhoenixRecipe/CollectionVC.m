//
//  CollectionVC.m
//  PhoenixRecipe
//
//  Created by Apple on 2017/11/25.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "CollectionVC.h"
#import "RecipeListTabCell.h"
#import "RecipeVC.h"
@interface CollectionVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray <RecipeModel *>*dataArray;
@end

@implementation CollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    [self tableView];
    [self getData];
}
- (void)getData{
    [[DataBase sharedDataBase] queryAllCol:^(NSArray<RecipeModel *> *dataArray) {
        self.dataArray = [NSMutableArray arrayWithArray:dataArray];
        [self.tableView reloadData];
    }];
}

static NSString *RecipeListTabCellID = @"RecipeListTabCell";
- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tableFooterView = [UIView new];
        [tableView emptyViewConfigerBlock:^(FOREmptyAssistantConfiger *configer) {
            
            configer.emptyImage = [UIImage imageNamed:@"placeholder"];
            configer.emptySubtitle = @"这里什么都没有";
            configer.emptyCenterOffset = CGPointMake(0, -100);
        }];
        [tableView registerClass:[RecipeListTabCell class] forCellReuseIdentifier:RecipeListTabCellID];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RecipeListTabCell *cell = [tableView dequeueReusableCellWithIdentifier:RecipeListTabCellID forIndexPath:indexPath];
    cell.recipe = self.dataArray[indexPath.row];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RecipeVC *recVC = [[RecipeVC alloc]init];
    recVC.recipe = self.dataArray[indexPath.row];
    
    [self.navigationController pushViewController:recVC animated:YES];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        if (indexPath.row<[self.dataArray count]) {
            [[DataBase sharedDataBase] delRecipeByID:self.dataArray[indexPath.row].id];
            [self.dataArray removeObjectAtIndex:indexPath.row];//移除数据源的数据
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];//移除tableView中的数据
        }
    }
}
@end
