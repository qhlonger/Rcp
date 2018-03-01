//
//  BaseVC.h
//  PhoenixRecipe
//
//  Created by mini on 2017/11/23.
//  Copyright © 2017年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseVC : UIViewController

- (void)setNavRightItem:(id)navRightItem callback:(void(^)(void))callback;

- (void)setNavLeftItem:(id)navLeftItem callback:(void(^)(void))callback;
@end
