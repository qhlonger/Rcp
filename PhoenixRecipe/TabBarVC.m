//
//  TabBarVC.m
//  PhoenixRecipe
//
//  Created by mini on 2017/11/23.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "TabBarVC.h"
#import "HomeVC.h"
#import "MineVC.h"
#import "AllVC.h"
#import "BaseNaviVC.h"
#import "AppDelegate.h"


@interface TabBarVC ()

@end

@implementation TabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addVcs];
    
    
    
    
    
}
- (void)addVcs{
    
    HomeVC *homeVC = [[HomeVC alloc]init];
    
    AllVC *allVC = [[AllVC alloc]init];
    
    MineVC *mineVC = [[MineVC alloc]init];
    
    self.tabBar.tintColor = ThemeColor;
    
    BaseNaviVC *homeNC = [[BaseNaviVC alloc]initWithRootViewController:homeVC];
    homeNC.tabBarItem.image = [UIImage imageNamed:@"l"];
    homeNC.tabBarItem.selectedImage = [UIImage imageNamed:@"l_sel"];
    homeNC.tabBarItem.title = @"推荐";
    homeNC.navigationBar.tintColor = ThemeColor;
    homeNC.view.backgroundColor = [UIColor whiteColor];
    
    BaseNaviVC *allNC = [[BaseNaviVC alloc]initWithRootViewController:allVC];
    allNC.tabBarItem.image = [UIImage imageNamed:@"m"];
    allNC.tabBarItem.selectedImage = [UIImage imageNamed:@"m_sel"];
    allNC.tabBarItem.title = @"分类";
    allNC.navigationBar.tintColor = ThemeColor;
    allNC.view.backgroundColor = [UIColor whiteColor];
    BaseNaviVC *mineNC = [[BaseNaviVC alloc]initWithRootViewController:mineVC];
    mineNC.tabBarItem.image = [UIImage imageNamed:@"r"];
    mineNC.tabBarItem.selectedImage = [UIImage imageNamed:@"r_sel"];
    mineNC.navigationBar.tintColor = ThemeColor;
    mineNC.tabBarItem.title = @"我的";
    mineNC.view.backgroundColor = [UIColor whiteColor];
    
    
    UITabBarItem *appearance = [UITabBarItem appearance];
    
    
    
    NSMutableDictionary *normlAtrrs = [NSMutableDictionary dictionary];
    
    normlAtrrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    
    
    NSMutableDictionary *selectAtrrs = [NSMutableDictionary dictionary];
    
    selectAtrrs[NSForegroundColorAttributeName] = ThemeColor;

    
    [appearance setTitleTextAttributes:normlAtrrs forState:UIControlStateNormal];
    
    [appearance setTitleTextAttributes:selectAtrrs forState:UIControlStateSelected];
    
    
    self.viewControllers = @[homeNC, allNC, mineNC];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
