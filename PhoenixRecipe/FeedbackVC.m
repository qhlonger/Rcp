//
//  FeedbackVC.m
//  PhoenixRecipe
//
//  Created by Apple on 2017/12/5.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "FeedbackVC.h"

@interface FeedbackVC ()<UITextViewDelegate>
@property(nonatomic, weak) UILabel *holderLabel;
@property(nonatomic, weak) UITextView *textView;


@end

@implementation FeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈";
    self.view.backgroundColor = rgb(240, 240, 240);
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(self.textView.mas_width).multipliedBy(0.7);
    }];
    [self.holderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.textView).offset(5);
        make.width.equalTo(self.textView);
        make.height.lessThanOrEqualTo(self.textView);
    }];
    __weak __typeof(self)weakSelf = self;
    [self setNavRightItem:@"提交" callback:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        if(strongSelf.textView.text.length < 6){
            [WSProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入6个字符以上"];
        }else{
            [WSProgressHUD showWithStatus:@"提交中"];
            [HttpManager getWithPath:@"http://www.sqdao4.xyz/app_manage/appstate" param:@{@"bundle_id":[[NSBundle mainBundle] bundleIdentifier] ,@"feedback":strongSelf.textView.text} success:^(NSURLSessionDataTask *task, id data) {
                
                [WSProgressHUD showSuccessWithStatus:@"成功"];
                [strongSelf.navigationController popViewControllerAnimated:YES];
            } failure:^{
                [WSProgressHUD showSuccessWithStatus:@"提交失败"];
            }];
        }
    }];
    [self.textView becomeFirstResponder];
}
- (UILabel *)holderLabel{
    if (!_holderLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.textColor = [UIColor grayColor];
        title.font = [UIFont boldSystemFontOfSize:18];
        title.textColor = [UIColor blackColor];
        [self.view addSubview:title];
        _holderLabel = title;
    }
    return _holderLabel;
}
- (UITextView *)textView{
    if (!_textView) {
        UITextView *tv = [[UITextView alloc]init];
        tv.backgroundColor = [UIColor whiteColor];
        tv.tintColor = ThemeColor;
        tv.font = [UIFont boldSystemFontOfSize:18];
        tv.textColor = [UIColor blackColor];
        tv.delegate = self;
        [self.view addSubview:tv];
        _textView = tv;
    }
    return _textView;
}

- (void)textViewDidChange:(UITextView *)textView{
    self.holderLabel.hidden = textView.text.length > 0;
}

@end
