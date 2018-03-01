//
//  MineVC.m
//  PhoenixRecipe
//
//  Created by mini on 2017/11/23.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "MineVC.h"
#import "MineCell.h"
#import "QMRightItem.h"
#import "AboutVC.h"
#import "CollectionVC.h"
#import "LearnedVC.h"
#import "FeedbackVC.h"
#import <Social/Social.h>
@interface MineVC ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray <NSArray <NSString *>*>*titles;
@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, strong) SLComposeViewController *composeVc;
@end

@implementation MineVC
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
    
    
    
//    [self setNavRightItem:[UIImage imageNamed:@"icon_s"] callback:^{
//
////        [self getToken];
//
//
//    }];
    
    
    self.titles = @[@[@"我已学会",@"我的收藏",],@[@"反馈",@"关于"]];
    self.title = @"我的";
  
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    
}

//-(NSString *)randomStr:(NSInteger)length{
//    //定义一个包含数字，大小写字母的字符串
//    NSString * strAll = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
//    //定义一个结果
//    NSString * result = [[NSMutableString alloc]initWithCapacity:16];
//    for (int i = 0; i < length; i++)
//    {
//        //获取随机数
//        NSInteger index = arc4random() % (strAll.length-1);
//        char tempStr = [strAll characterAtIndex:index];
//        result = (NSMutableString *)[result stringByAppendingString:[NSString stringWithFormat:@"%c",tempStr]];
//    }
//
//    return result;
//}

//- (void)getToken{
//    //get   token
//    [HttpManager getWithPath:@"http://39.108.118.115:7200/zf/sign.php" param:@{}  success:^(NSURLSessionDataTask *task, id data) {
//
//
//        NSMutableDictionary *para = [@[] mutableCopy];
//        [para setObject:@"1000020" forKey:@"mch_id"];//商户号
//        [para setObject:[self randomStr:32] forKey:@"out_trade_no"];//商户订单号
//        [para setObject:@"nias" forKey:@"body"];//商品描述
//        [para setObject:@"1" forKey:@"total_fee"];//总金额
//        [para setObject:[Util getIPAddress:YES] forKey:@"mch_create_ip"];//终端IP
//        [para setObject:@"http://39.108.118.115:7200/zf/index.php" forKey:@"notify_url"];//通知地址
//        [para setObject:[self randomStr:32] forKey:@"nonce_str"];//随机字符串
//
////        [para setObject:@"" forKey:@"sign"];//签名
//
//
//        [HttpManager getWithPath:@"http://39.108.118.115:7200/zf/sign.php" param:@{}  success:^(NSURLSessionDataTask *task, id data) {
//
//
//            [HttpManager getWithPath:@"http://api.qftx1.com/api/sig/v1/wx/native" param:@{@"token":data[@"value"]} success:^(NSURLSessionDataTask *task, id data) {
//
//
//
//
//            } failure:^{
//
//            }];
//
//
//        } failure:^{
//
//        }];
//
//
//    } failure:^{
//
//    }];
//}



static NSString *MineCellID = @"MineCell";
- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
//        tableView.separatorStyle = UITableViewCellEditingStyleNone;
        tableView.backgroundColor  = [UIColor whiteColor];
        [tableView registerClass:[MineCell class] forCellReuseIdentifier:MineCellID];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:MineCellID forIndexPath:indexPath];
    cell.titleLabel.text = self.titles[indexPath.section][indexPath.row];
    cell.titleLabel.textColor = ThemeColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *str = [Util getIPAddress:YES] ;
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([self.titles[indexPath.section][indexPath.row] isEqualToString:@"反馈"]){
        [self.navigationController pushViewController:[[FeedbackVC alloc]init] animated:YES];
        
    }else if([self.titles[indexPath.section][indexPath.row] isEqualToString:@"我已学会"]){
        [self.navigationController pushViewController:[[LearnedVC alloc]init] animated:YES];
        
    }else if([self.titles[indexPath.section][indexPath.row] isEqualToString:@"我的收藏"]){
        [self.navigationController pushViewController:[[CollectionVC alloc]init] animated:YES];
        
    }else if([self.titles[indexPath.section][indexPath.row] isEqualToString:@"关于"]){
        [self.navigationController pushViewController:[[AboutVC alloc]init] animated:YES];

    }
}

@end
