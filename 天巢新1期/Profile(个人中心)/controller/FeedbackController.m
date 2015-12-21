//
//  FeedbackController.m
//  天巢新1期
//
//  Created by 赵贺 on 15/12/16.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "FeedbackController.h"
#import "UIImage+ColorToBackImage.h"
#import "TCTextView.h"
#define margin 10

@interface FeedbackController ()
@property (nonatomic,strong)NSArray *questions;
@end


@implementation FeedbackController


-(NSArray *)questions
{
    if (!_questions) {
        _questions = @[@"软件问题",@"物流问题",@"商品问题",@"退换货问题",@"其他问题"];
    }
    return _questions;
}
-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -64, ApplicationframeValue.width, ApplicationframeValue.height+64-35)];
    scrollView.bounces = YES;
    scrollView.contentSize = CGSizeMake(ApplicationframeValue.width, ApplicationframeValue.height+64);
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    
/**反馈类型*/
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 64, ApplicationframeValue.width, 45)];
    [scrollView addSubview:titleLabel];
    titleLabel.text = @"反馈类型";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = AppFont(15);
    
/**横线1*/
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleLabel.origin.y+titleLabel.size.height, ApplicationframeValue.width, 0.3f)];
    lineView.backgroundColor = [Color_LightGray colorWithAlphaComponent:0.3f];
    [scrollView addSubview:lineView];

    UIView *SelectedView = [[UIView alloc] initWithFrame:CGRectMake(0, lineView.origin.y+lineView.size.height, ApplicationframeValue.width, 80)];
//    SelectedView.backgroundColor = Color_LightGray;
    [scrollView addSubview:SelectedView];
    
    SelectedView.layer.borderWidth = 0.3f;
    SelectedView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    
    for (int i = 0; i<5; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.questions[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        if (i<3) {
            button.frame = CGRectMake(margin+i*(80+margin), 10, 80, 20);
        }else{
        
        button.frame = CGRectMake(margin+(i-3)*(80+margin), 45, 80, 20);
        
        }
        button.tag = 100 + i;
        button.titleLabel.font = AppFont(12);
        [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:button.frame.size] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:AppColor size:button.frame.size] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(Onclick:) forControlEvents:UIControlEventTouchUpInside];
        [SelectedView addSubview:button];
        button.selected = NO;
        button.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f].CGColor;
        button.layer.borderWidth = 0.3f;
        
    }
 /**横线2*/
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, SelectedView.origin.y+SelectedView.size.height+10, ApplicationframeValue.width, 0.3f)];
    lineView2.backgroundColor = [Color_LightGray colorWithAlphaComponent:0.3f];
    [scrollView addSubview:lineView2];
    
    
    
    /**反馈内容*/
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, lineView2.origin.y+lineView2.size.height+10, ApplicationframeValue.width, 45)];
    detailLabel.text = @"  反馈内容";
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.font = AppFont(15);
    [scrollView addSubview:detailLabel];
    
    detailLabel.layer.borderWidth = 0.3f;
    detailLabel.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    
/**横线3*/
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, detailLabel.origin.y+detailLabel.size.height+10, ApplicationframeValue.width, 0.3f)];
    lineView3.backgroundColor = [Color_LightGray colorWithAlphaComponent:0.3f];
    [scrollView addSubview:lineView3];
    
    /**反馈*/
    TCTextView *textView = [[TCTextView alloc] initWithFrame:CGRectMake(0, lineView3.origin.y+lineView3.size.height, ApplicationframeValue.width, 100)];
    textView.placeholder = @"乐意聆听您对天巢手机客户端的任何建议";
    

    [scrollView addSubview:textView];
    
    /**联系方式*/
    UILabel *connectLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, textView.origin.y+textView.size.height+10, ApplicationframeValue.width, 45)];
    connectLabel.text = @"  联系方式";
    connectLabel.textAlignment = NSTextAlignmentLeft;
    connectLabel.layer.borderWidth = 0.3f;
    connectLabel.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    connectLabel.font = AppFont(15);
    [scrollView addSubview:connectLabel];
    
    /**横线4*/
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, connectLabel.origin.y+connectLabel.size.height, ApplicationframeValue.width, 0.3f)];
    lineView4.backgroundColor = [Color_LightGray colorWithAlphaComponent:0.3f];
    [scrollView addSubview:lineView4];
    
    
    
    UITextField *PhoneTextView = [[UITextField alloc] initWithFrame:CGRectMake(0, lineView4.origin.y+lineView4.size.height, ApplicationframeValue.width, 45)];
    PhoneTextView.placeholder = @"  手机号码或邮箱（选填）";
    PhoneTextView.font = AppFont(12);
    PhoneTextView.layer.borderWidth = 0.3f;
    PhoneTextView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    [scrollView addSubview:PhoneTextView];
    
    
    /**提交按钮*/
    UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, ApplicationframeValue.height-35, ApplicationframeValue.width, 35)];
    [self.view addSubview:submitBtn];
    submitBtn.backgroundColor = AppColor;
    NSLog(@"height:%f",ApplicationframeValue.height);
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.titleLabel.textColor = AppColor;
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    submitBtn.titleLabel.font = AppFont(12);

}


-(void)Onclick:(UIButton *)sender{
    sender.selected = !sender.selected;
    
}

@end
