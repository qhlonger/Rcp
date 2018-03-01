//
//  RecipeVC.m
//  PhoenixRecipe
//
//  Created by mini on 2017/11/24.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "RecipeVC.h"
#import "RecipeProcessCell.h"
#import "RecipeMaterialCell.h"
#import "AllSectionHeader.h"
#import "RecipeHeaderCell.h"
@interface RecipeVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, weak) UITableView *tableView;


@property(nonatomic, weak) UIButton *collectionBtn;
@property(nonatomic, weak) UIButton *learnedBtn;


@end

@implementation RecipeVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self tableView];
//    [self learnedBtn];
//    [self collectionBtn];
    [self layout];
    [self getData];
    [self tableView];
    if(self.allowRandom){
        __weak __typeof(self)weakSelf = self;
        [self setNavRightItem:@"随便看看" callback:^{
            [weakSelf getData];
        }];
    }
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.view bringSubviewToFront:self.collectionBtn];
    [self.view bringSubviewToFront:self.learnedBtn];
        self.collectionBtn.frame = CGRectMake(CGRectGetWidth(self.view.frame)-50-20, CGRectGetHeight(self.view.frame)-60, 50, 50);
        self.learnedBtn.frame = CGRectMake(CGRectGetWidth(self.view.frame)-140, CGRectGetHeight(self.view.frame)-60, 50, 50);

}
- (void)layout{
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
//    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 50, 0);
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.bottom.equalTo(self.view);
//        make.bottom.equalTo(self.view).offset(-40);
//    }];
//    [self.collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.mas_equalTo(40);
//        make.right.equalTo(self.view).offset(-15);
//        make.bottom.equalTo(self.view).offset(-15);
//
////        make.right.bottom.equalTo(self.view);
////        make.height.mas_equalTo(50);
////        make.width.equalTo(self.learnedBtn.mas_width).offset(1);
////        make.left.equalTo(self.learnedBtn.mas_right).offset(-1);
//    }];
//    [self.learnedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.mas_equalTo(40);
//        make.right.equalTo(self.view).offset(-15);
//        make.bottom.equalTo(self.collectionBtn.mas_top).offset(-15);
////        make.left.bottom.equalTo(self.view);
////        make.height.mas_equalTo(50);
////        make.width.equalTo(self.view.mas_width).multipliedBy(0.5);
//    }];
}
- (void)setRecipe:(RecipeModel *)recipe{
    _recipe = recipe;
    self.title = recipe.name;
    if(_tableView)
        [self.tableView reloadData];
//    [self getData];
}
- (UIButton *)learnedBtn{
    if (!_learnedBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius = 25;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = ThemeColor.CGColor;
        [btn setBackgroundImage:[UIImage imageWithColor:ThemeColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
//        [btn setTitle:@"" forState:UIControlStateSelected];
        [btn setTitle:@"我已\n学会" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        btn.titleLabel.numberOfLines = 2;
        __weak __typeof(self)weakSelf = self;
        [btn bk_addEventHandler:^(UIButton* sender) {
            sender.selected = !sender.selected;
            weakSelf.recipe.didlearn = sender.selected ? @1 : @0;
            [WSProgressHUD showSuccessWithStatus:[NSString stringWithFormat: @"%@“学会”",(sender.selected?@"已标记为":@"取消标记")]];
            [[DataBase sharedDataBase]updateRecipe:weakSelf.recipe];
            
        } forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _learnedBtn = btn;
    }
    return _learnedBtn;
}
- (UIButton *)collectionBtn{
    if (!_collectionBtn) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius = 25;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = ThemeColor.CGColor;
        [btn setBackgroundImage:[UIImage imageWithColor:ThemeColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        //        [btn setTitle:@"" forState:UIControlStateSelected];
        [btn setTitle:@"收藏" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        __weak __typeof(self)weakSelf = self;
        [btn bk_addEventHandler:^(UIButton* sender) {
            
            sender.selected = !sender.selected;
            weakSelf.recipe.didcol = sender.selected ? @1 : @0;
            [WSProgressHUD showSuccessWithStatus:[NSString stringWithFormat: @"%@收藏成功",sender.selected?@"":@"取消"]];
                
            [[DataBase sharedDataBase]updateRecipe:weakSelf.recipe];
            
        } forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _collectionBtn = btn;
    }
    return _collectionBtn;
}
- (void)getData{
    NSNumber *aID ;
    if(!self.recipe && !self.recipeId){
        self.allowRandom = YES;
    }
    
    
    if(self.recipe){
        aID = self.recipe.id;
    }
    if (self.recipeId) {
        aID = self.recipeId;
    }
    if(self.allowRandom){
        aID = [[Util getRandomId:1] firstObject];
    }
    
    
    
    
    [HttpManager getWithPath:[NSString stringWithFormat:@"%@%@",RecipePath,@"recipe/detail"] param:@{@"id":aID} showProgress:YES showMsg:NO success:^(NSURLSessionDataTask *task, id data) {
        self.recipe = [RecipeModel mj_objectWithKeyValues:data];
        
        [[DataBase sharedDataBase] getRecipeByID:self.recipe.id callBack:^(RecipeModel *model) {
            if(model){
                self.recipe.didlearn = model.didlearn;
                self.recipe.didcol = model.didcol;
                self.collectionBtn.selected = [self.recipe.didcol isEqualToNumber:@1] ;
                self.learnedBtn.selected = [self.recipe.didlearn isEqualToNumber:@1] ;
                [[DataBase sharedDataBase] updateRecipe:self.recipe];
            }else{
                self.collectionBtn.selected = NO ;
                self.learnedBtn.selected = NO ;
                [[DataBase sharedDataBase] addRecipe:self.recipe];
            }
        }];
        
        
        
    } failure:^{
        
    }];
}

static NSString *RecipeMaterialCellID = @"RecipeMaterialCell";
static NSString *RecipeProcessCellID = @"RecipeProcessCell";
static NSString *AllSectionHeaderID = @"AllSectionHeader";
static NSString *RecipeHeaderCellID = @"RecipeHeaderCell";
- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass:[RecipeMaterialCell class] forCellReuseIdentifier:RecipeMaterialCellID];
        [tableView registerClass:[RecipeProcessCell class] forCellReuseIdentifier:RecipeProcessCellID];
        [tableView registerClass:[AllSectionHeader class] forHeaderFooterViewReuseIdentifier:AllSectionHeaderID];
        [tableView registerClass:[RecipeHeaderCell class] forCellReuseIdentifier:RecipeHeaderCellID];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 1;
    }else if(section == 1){
        return self.recipe.material.count;
    }else if(section == 2){
        return self.recipe.process.count;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        return  [tableView fd_heightForCellWithIdentifier:RecipeHeaderCellID configuration:^(RecipeHeaderCell *cell) {
            
            cell.cTimeLabel.text = self.recipe.cookingtime?[NSString stringWithFormat:@"烹饪时间 : %@",self.recipe.cookingtime]:@"";
            cell.pTimeLabel.text = self.recipe.preparetime?[NSString stringWithFormat:@"准备时间 : %@",self.recipe.preparetime]:@"";
            cell.descLabel.text = self.recipe.content?[NSString stringWithFormat:@"介绍 : %@",self.recipe.content]:@"";
            cell.tagLabel.text = self.recipe.tag?[NSString stringWithFormat:@"标签 : %@",self.recipe.tag]:@"";
            cell.peopleLabel.text = self.recipe.peoplenum?[NSString stringWithFormat:@"适宜人数 : %@",self.recipe.peoplenum]:@"";
            
        }];
    }else if(indexPath.section == 1){
        return 40;
    }else if(indexPath.section == 2){
        return [tableView fd_heightForCellWithIdentifier:RecipeProcessCellID configuration:^(RecipeProcessCell *cell) {
            cell.titleLabel.text = self.recipe.processModels[indexPath.row].pcontent;
            cell.detailLabel.text = self.recipe.processModels[indexPath.row].pcontent;
            [cell.iconView sd_setImageWithURL:[NSURL URLWithString:self.recipe.processModels[indexPath.row].pic] placeholderImage:[UIImage imageWithColor:RGBA(240, 240, 240, 1)] ];
        }];
    }else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AllSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:AllSectionHeaderID];
    header.moreBtn.hidden = YES;
    if (section == 0) {
        header.titleLabel.text = @"介绍";
    }else if(section == 1){
        header.titleLabel.text = @"材料";
    }else{
        header.titleLabel.text = @"过程";
    }
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        RecipeHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:RecipeHeaderCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.iconView sd_setImageWithURL:[NSURL URLWithString:self.recipe.pic] placeholderImage:[UIImage imageWithColor:RGBA(240, 240, 240, 1)] ];
        cell.cTimeLabel.text = self.recipe.cookingtime?[NSString stringWithFormat:@"烹饪时间 : %@",self.recipe.cookingtime]:@"";
        cell.pTimeLabel.text = self.recipe.preparetime?[NSString stringWithFormat:@"准备时间 : %@",self.recipe.preparetime]:@"";
        cell.descLabel.text = self.recipe.content?[NSString stringWithFormat:@"介绍 : %@",self.recipe.content]:@"";
        cell.tagLabel.text = self.recipe.tag?[NSString stringWithFormat:@"标签 : %@",self.recipe.tag]:@"";
        cell.peopleLabel.text = self.recipe.peoplenum?[NSString stringWithFormat:@"适宜人数 : %@",self.recipe.peoplenum]:@"";
        return cell;
    }else if(indexPath.section == 1){
        RecipeMaterialCell *cell = [tableView dequeueReusableCellWithIdentifier:RecipeMaterialCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = self.recipe.materialModels[indexPath.row].mname;
        cell.detailLabel.text = self.recipe.materialModels[indexPath.row].amount;
        return cell;
    }else if(indexPath.section == 2){
        RecipeProcessCell  *cell = [tableView dequeueReusableCellWithIdentifier:RecipeProcessCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = self.recipe.processModels[indexPath.row].pcontent;
        cell.detailLabel.text = self.recipe.processModels[indexPath.row].pcontent;
        [cell.iconView sd_setImageWithURL:[NSURL URLWithString:self.recipe.processModels[indexPath.row].pic] placeholderImage:[UIImage imageWithColor:RGBA(240, 240, 240, 1)] ];
        cell.markLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        return cell;
    }
    
    
    return nil;
}


@end
