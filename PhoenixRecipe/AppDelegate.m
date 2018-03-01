//
//  AppDelegate.m
//  PhoenixRecipe
//
//  Created by mini on 2017/11/23.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "AppDelegate.h"
#import "CoverView+Bmob.h"
#import "TabBarVC.h"

#import <BmobSDK/Bmob.h>
@interface AppDelegate ()
@property(nonatomic, strong) UIWindow *adWindow;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[TabBarVC alloc]init];
    [self.window makeKeyAndVisible];
    
    [Bmob registerWithAppKey:@"306fec5898fff849f93f1c887dab0466"];
    
    
    [[CoverView sharedInstance]show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[CoverView sharedInstance]hide];
    });
    
//    BmobQuery *query = [BmobQuery queryWithClassName:@"ap"];
//    query.limit = 1;
//    [query orderByDescending:@"createdAt"];
//    [query whereKey:@"aname" equalTo:@"菜谱"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//        if(array.count > 0){
//            BmobObject *obj = array.lastObject;
//            if([[obj objectForKey:@"st"] isEqualToString:@"1"])
//                [[CoverView sharedInstance].adView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[obj objectForKey:@"info"]]]];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([[obj objectForKey:@"dur"] integerValue] * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [[CoverView sharedInstance]hide];
//            });
//        }else{
//            [[CoverView sharedInstance]hide];
//        }
//    }];
    
    
    
    
    
    

    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
