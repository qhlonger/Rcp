//
//  CategoryListVC.m
//  PhoenixRecipe
//
//  Created by mini on 2017/11/24.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "CategoryListVC.h"

@interface CategoryListVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, weak) UITableView *tableView;
@end

@implementation CategoryListVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)setCategoryResult:(RecipeCategoryResult *)categoryResult{
    _categoryResult = categoryResult;
    self.title = categoryResult.name ;
    [self.tableView reloadData];
}


static NSString *CellID = @"CellID";
- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoryResult.modelList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.textLabel.text = self.categoryResult.modelList[indexPath.row].name;
    cell.textLabel.textColor = self.categoryResult.modelList[indexPath.row].color;
//    cell.backgroundColor = self.categoryResult.modelList[indexPath.row].color;
    cell.textLabel.font = [UIFont systemFontOfSize:22];
    cell.tintColor = ThemeColor;
    if([self.category.classid isEqualToNumber:self.categoryResult.modelList[indexPath.row].classid]){
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.selectCategory){
        self.selectCategory(self,self.categoryResult.modelList[indexPath.row]);
    }
    
}
@end
