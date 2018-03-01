//
//  DataBase.m
//  FMDBDemo
//
//  Created by Zeno on 16/5/18.
//  Copyright © 2016年 zenoV. All rights reserved.
//

#import "DataBase.h"

#import <FMDB.h>


static DataBase *_DBCtl = nil;

@interface DataBase()<NSCopying,NSMutableCopying>{
    FMDatabase  *_db;
    
}




@end

@implementation DataBase

+(instancetype)sharedDataBase{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [[DataBase alloc] init];
        
        [_DBCtl initDataBase];
        
    }
    
    return _DBCtl;
    
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [super allocWithZone:zone];
        
    }
    
    return _DBCtl;
    
}

-(id)copy{
    
    return self;
    
}

-(id)mutableCopy{
    
    return self;
    
}

-(id)copyWithZone:(NSZone *)zone{
    
    return self;
    
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    
    return self;
    
}


-(void)initDataBase{
    // 获得Documents目录路径
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 文件路径
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"model.sqlite"];
    
    // 实例化FMDataBase对象
    
    _db = [FMDatabase databaseWithPath:filePath];
    
    [_db open];
    
    // 初始化数据表
    
    NSString *recipeSQL = @"CREATE TABLE 'recipe' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'recipe_id' VARCHAR(255), 'name' VARCHAR(255), 'content' TEXT, 'tag' TEXT , 'pic' TEXT, 'didcol' VARCHAR(2), 'didlearn' VARCHAR(2))    " ;

    
    [_db executeUpdate:recipeSQL];

    
    
    [_db close];

}
#pragma mark - 接口
- (void)addRecipe:(RecipeModel *)recipe{
    
    [self getRecipeByID:recipe.id callBack:^(RecipeModel *re) {
        if(re){
            [self updateRecipe:recipe];
        }else{
            [_db open];
            [_db executeUpdate:@"INSERT INTO recipe(recipe_id, name, content, tag, pic, didcol, didlearn) VALUES(?,?,?,?,?,?,?)",
             recipe.id, recipe.name,recipe.content, recipe.tag, recipe.pic, recipe.didcol, recipe.didlearn];
            
            [_db close];
        }
    }];
}
- (void)updateRecipe:(RecipeModel *)recipe{
    [_db open];
    BOOL suc = [_db executeUpdate:@"UPDATE 'recipe' SET didcol = ? WHERE recipe_id = ?", recipe.didcol, recipe.id];
    suc = [_db executeUpdate:@"UPDATE 'recipe' SET didlearn = ? WHERE recipe_id = ?", recipe.didlearn, recipe.id];
    [_db close];
}

- (void)queryAllCol:(void(^)(NSArray<RecipeModel *>*))callback{
//- (NSArray<RecipeModel *>*)queryAllCol{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM recipe WHERE didcol = 1"];
    
    while ([res next]) {
        RecipeModel *recipe = [[RecipeModel alloc] init];
        recipe.id = @([[res stringForColumn:@"recipe_id"] integerValue]);
        recipe.name = [res stringForColumn:@"name"];
        recipe.content = [res stringForColumn:@"content"];
        recipe.tag = [res stringForColumn:@"tag"];
        recipe.pic = [res stringForColumn:@"pic"];
        recipe.didlearn = @([[res stringForColumn:@"didlearn"] integerValue]);
        recipe.didcol = @([[res stringForColumn:@"didcol"] integerValue]);
        
        
        [dataArray addObject:recipe];
        
    }
    
    [_db close];
    if(callback)callback(dataArray);
}

- (void)queryAllLearn:(void(^)(NSArray<RecipeModel *>*))callback{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM recipe WHERE didlearn = 1"];
    
    while ([res next]) {
        RecipeModel *recipe = [[RecipeModel alloc] init];
        recipe.id = @([[res stringForColumn:@"recipe_id"] integerValue]);
        recipe.name = [res stringForColumn:@"name"];
        recipe.content = [res stringForColumn:@"content"];
        recipe.tag = [res stringForColumn:@"tag"];
        recipe.pic = [res stringForColumn:@"pic"];
        recipe.didlearn = @([[res stringForColumn:@"didlearn"] integerValue]);
        recipe.didcol = @([[res stringForColumn:@"didcol"] integerValue]);
        
        
        [dataArray addObject:recipe];
        
    }
    
    [_db close];
    if(callback)callback(dataArray);
}
- (void)getRecipeByID:(NSNumber *)aID callBack:(void(^)(RecipeModel *))callback{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM recipe WHERE recipe_id = ?", aID];
    
    while ([res next]) {
        RecipeModel *recipe = [[RecipeModel alloc] init];
        recipe.id = @([[res stringForColumn:@"recipe_id"] integerValue]);
        recipe.name = [res stringForColumn:@"name"];
        recipe.content = [res stringForColumn:@"content"];
        recipe.tag = [res stringForColumn:@"tag"];
        recipe.pic = [res stringForColumn:@"pic"];
        recipe.didlearn = @([[res stringForColumn:@"didlearn"] integerValue]);
        recipe.didcol = @([[res stringForColumn:@"didcol"] integerValue]);
        
        
        [dataArray addObject:recipe];
        
    }
    
    [_db close];
    if(dataArray.count){
        if(callback)
            callback(dataArray.firstObject);
    }else{
        if(callback)
            callback(nil);
    }
}
- (void)delRecipeByID:(NSNumber *)aID{
    [_db open];
    [_db executeUpdate:@"DELETE FROM 'recipe' WHERE recipe_id = ?", aID];
    [_db close];
}
@end
