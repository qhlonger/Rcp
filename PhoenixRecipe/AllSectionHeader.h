//
//  AllSectionHeader.h
//  PhoenixRecipe
//
//  Created by mini on 2017/11/23.
//  Copyright © 2017年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllSectionHeader : UITableViewHeaderFooterView

@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UILabel  *detailLabel;
@property(nonatomic, weak) UIButton *moreBtn;


@property(nonatomic, copy) void(^didSelectAllBtn) (void);
@end
