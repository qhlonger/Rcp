//
//  RecpieListVC.m
//  PhoenixRecipe
//
//  Created by Apple on 2018/2/5.
//  Copyright © 2018年 mini. All rights reserved.
//

#import "RecpieListVC.h"
#import "RecipeListTabCell.h"
#import "RecipeVC.h"

@interface RecpieListVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, weak) UITableView *tableView;

@end

@implementation RecpieListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    
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

@end
