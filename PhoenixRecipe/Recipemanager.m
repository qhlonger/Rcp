//
//  Recipemanager.m
//  PhoenixRecipe
//
//  Created by Apple on 2017/12/1.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "Recipemanager.h"

@implementation Recipemanager

+ (instancetype)manager{
    static Recipemanager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[Recipemanager alloc]init];
    });
    return manager;
}
+ (void)getRecipes:(void (^)(NSArray<RecipeCategoryResult *> *))callback{
    if([Recipemanager manager].recipes){
        if(callback)callback([Recipemanager manager].recipes);
    }else{
        [HttpManager getWithPath:[NSString stringWithFormat:@"%@%@",RecipePath,@"recipe/class"] param:nil showProgress:NO showMsg:NO success:^(NSURLSessionDataTask *task, id data) {
            NSMutableArray *dataArray = [RecipeCategoryResult mj_objectArrayWithKeyValuesArray:data];
            [Recipemanager manager].recipes = dataArray;
            if(callback)callback(dataArray);
        } failure:^{
            if(callback)callback(nil);
        }];
    }
}


@end
