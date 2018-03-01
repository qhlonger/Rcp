//
//  BaseVC.m
//  PhoenixRecipe
//
//  Created by mini on 2017/11/23.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "BaseVC.h"
#import "QMRightItem.h"
@interface BaseVC ()

@end

@implementation BaseVC
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavRightItem:(id)navRightItem callback:(void(^)(void))callback{
    if ([navRightItem isKindOfClass:[NSString class]]) {
        
        QMRightItem *item = [[QMRightItem alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
        [item.btn setTitle:navRightItem forState:UIControlStateNormal];
        [item.btn setTitleColor:ThemeColor forState:UIControlStateNormal];
        [item.btn bk_addEventHandler:^(id sender) {
            if(callback)callback();
        } forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:item];
        
        self.navigationItem.rightBarButtonItem = barItem;
        
    }else if([navRightItem isKindOfClass:[UIImage class]]){
        
        QMRightItem *item = [[QMRightItem alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
            [item.btn setImage:[navRightItem imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [item.btn bk_addEventHandler:^(id sender) {
            if(callback)callback();
        } forControlEvents:UIControlEventTouchUpInside];
        [item.btn setTitleColor:ThemeColor forState:UIControlStateNormal];
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:item];
        
        self.navigationItem.rightBarButtonItem = barItem;
        
    }
}

- (void)setNavLeftItem:(id)navLeftItem callback:(void(^)(void))callback{
    if ([navLeftItem isKindOfClass:[NSString class]]) {
        
        QMRightItem *item = [[QMRightItem alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
        [item.btn setTitle:navLeftItem forState:UIControlStateNormal];
        [item.btn setTitleColor:ThemeColor forState:UIControlStateNormal];
        
        item.btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [item.btn bk_addEventHandler:^(id sender) {
            if(callback)callback();
        } forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:item];
        
        self.navigationItem.leftBarButtonItem = barItem;
        
    }else if([navLeftItem isKindOfClass:[UIImage class]]){
        
        QMRightItem *item = [[QMRightItem alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
        item.btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [item.btn setImage:[navLeftItem imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [item.btn bk_addEventHandler:^(id sender) {
            if(callback)callback();
        } forControlEvents:UIControlEventTouchUpInside];
        [item.btn setTitleColor:ThemeColor forState:UIControlStateNormal];
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:item];
        
        self.navigationItem.leftBarButtonItem = barItem;
        
    }
}


@end
