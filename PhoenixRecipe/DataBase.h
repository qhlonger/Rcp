//
//  DataBase.h
//  FMDBDemo
//
//  Created by Zeno on 16/5/18.
//  Copyright © 2016年 zenoV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecipeModel.h"



@interface DataBase : NSObject

@property(nonatomic,strong) RecipeModel *recipe;


+(instancetype)sharedDataBase;



#pragma mark - 接口
- (void)addRecipe:(RecipeModel *)recipe;
- (void)updateRecipe:(RecipeModel *)recipe;
- (void)queryAllCol:(void(^)(NSArray<RecipeModel *>*))callback;
- (void)queryAllLearn:(void(^)(NSArray<RecipeModel *>*))callback;

- (void)delRecipeByID:(NSNumber *)aID;
- (void)getRecipeByID:(NSNumber *)aID callBack:(void(^)(RecipeModel *))callback;


@end
