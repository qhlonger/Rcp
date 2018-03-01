//
//  RecipeModel.h
//  PhoenixRecipe
//
//  Created by mini on 2017/11/24.
//  Copyright © 2017年 mini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProcessModel : NSObject
@property(nonatomic, copy) NSString *pic;
@property(nonatomic, copy) NSString *pcontent;


@end



@interface MaterialModel : NSObject
@property(nonatomic, copy) NSString *mname;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *amount;

@end




@interface RecipeModel : NSObject

@property(nonatomic, strong) NSArray *process;
@property(nonatomic, strong) NSArray <ProcessModel*>*processModels;

@property(nonatomic, copy) NSString *content;
@property(nonatomic, assign) NSNumber *id;
@property(nonatomic, assign) NSNumber *classid;
@property(nonatomic, copy) NSString *pic;

@property(nonatomic, strong) NSArray *material;
@property(nonatomic, strong) NSArray <MaterialModel*>*materialModels;

@property(nonatomic, copy) NSString *preparetime;
@property(nonatomic, copy) NSString *cookingtime;
@property(nonatomic, copy) NSString *tag;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *peoplenum;



@property(nonatomic, assign) NSNumber *didcol;
@property(nonatomic, assign) NSNumber *didlearn;







@end
