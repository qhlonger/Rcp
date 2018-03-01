//
//  CoverView+Bmob.m
//  PhoenixRecipe
//
//  Created by Apple on 2018/2/5.
//  Copyright © 2018年 mini. All rights reserved.
//

#import "CoverView+Bmob.h"
#import <objc/runtime.h>
@implementation CoverView (Bmob)





static NSString *adK = @"PKCPADVK";
- (UIWebView *)adView{
    UIWebView *ad = objc_getAssociatedObject(self, &adK);
    if(ad)return ad;
    ad = [[UIWebView alloc]initWithFrame:self.bounds];
    [self addSubview:ad];
    objc_setAssociatedObject(self, &adK, ad, OBJC_ASSOCIATION_RETAIN);
    return ad;
}




@end
