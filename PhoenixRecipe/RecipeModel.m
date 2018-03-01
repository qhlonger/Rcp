//
//  RecipeModel.m
//  PhoenixRecipe
//
//  Created by mini on 2017/11/24.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "RecipeModel.h"

@implementation RecipeModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.didlearn = @0;
        self.didcol = @0;
    }
    return self;
}
- (void)setMaterial:(NSArray *)material{
    _material = material;
    self.materialModels = [MaterialModel mj_objectArrayWithKeyValuesArray:material];
}
- (void)setProcess:(NSArray *)process{
    _process = process;
    self.processModels = [ProcessModel mj_objectArrayWithKeyValuesArray:process];
}

- (void)setContent:(NSString *)content{
    _content = [content stringByDeletingHtmlLabel];
}


@end
@implementation ProcessModel : NSObject

- (void)setPcontent:(NSString *)pcontent{
    _pcontent = [pcontent stringByDeletingHtmlLabel];
}

@end



@implementation MaterialModel : NSObject

@end



