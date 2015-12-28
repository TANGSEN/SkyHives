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

@interface FeedbackController ()<UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic,strong)NSArray *questions;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UITextField *PhoneTextField;
@property (nonatomic,strong)TCTextView *textView;
@property (nonatomic,strong)UIView *PhoneView;

@end


@implementation FeedbackController


-(NSArray *)questions
{
    if (!_questions) {
        _questions = @[@"软件问题",@"物流问题",@"商品问题",@"退换货问题",@"其他问题"];
    }
    return _questions;
}


-(void)viewWillAppear:(BOOL)animated
{
    /**键盘弹起*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyborardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    /**键盘落下*/
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHidden) name:UIKeyboardDidHideNotification object:nil];
    
    
    
}


/**键盘弹起*/
-(void)keyborardDidShow:(NSNotification *)Info{
    
    NSValue *keyboardObject = [[Info userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect;
    [keyboardObject getValue:&keyboardRect];
    
    [UIView animateWithDuration:0.15f animations:^{
        
        CGFloat textViewY = self.textView.y+self.textView.height;
        CGFloat textFiledY = self.PhoneView.y+self.PhoneView.height;
        CGFloat keyboardY = self.scrollView.height - keyboardRect.size.height;
        if (self.textView.isFirstResponder) {
            if (textViewY<keyboardY) {
                return ;
            }
            else{
                
                self.scrollView.y -= (textViewY-keyboardY)+20;
            }
        }
        if(self.PhoneTextField.isFirstResponder)
        {
            
            if (textFiledY<keyboardY) {
                return ;
            }
            else{
                
                self.scrollView.y -= (textFiledY-keyboardY)+20;
            }
            
            
        }
        
        NSLog(@"textViewY%f\nkeyboardY%f",textViewY,keyboardY);
        
    }];
    
    [UIView commitAnimations];
    
    
}

-(void)keyboardDidHidden
{
    //定义动画
    [UIView beginAnimations:nil context:nil];
    //设置view的frame，往下平移
    [UIView animateWithDuration:0.15f animations:^{
        
        self.scrollView.frame = CGRectMake(0, -64, ApplicationframeValue.width, ApplicationframeValue.height+64-35);
    }];
    [UIView commitAnimations];
}
-(void)viewDidLoad
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -64, ApplicationframeValue.width, ApplicationframeValue.height+64-35)];
    scrollView.bounces = YES;
    scrollView.scrollEnabled = NO;
    scrollView.contentSize = CGSizeMake(ApplicationframeValue.width, ApplicationframeValue.height+64);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.backgroundColor = View_BgColor;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    /**反馈类型*/
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, ApplicationframeValue.width, 45)];
    [scrollView addSubview:titleLabel];
    titleLabel.text = @"  反馈类型";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = AppFont(15);
    titleLabel.backgroundColor = [UIColor whiteColor];
    
    
    /**问题选项*/
    UIView *SelectedView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), ApplicationframeValue.width, 80)];
    [scrollView addSubview:SelectedView];
    SelectedView.backgroundColor = [UIColor whiteColor];
    SelectedView.layer.borderWidth = 0.3f;
    SelectedView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    
    for (int i = 0; i<5; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.questions[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        if (i<3) {
            button.frame = CGRectMake(margin+i*(80+margin), 10, 80, 25);
        }else{
            
            button.frame = CGRectMake(margin+(i-3)*(80+margin), 45, 80, 25);
            
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
    
    
    /**反馈*/
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(SelectedView.frame)+15, ApplicationframeValue.width, 45)];
    detailLabel.text = @"  反馈内容";
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.font = AppFont(15);
    [scrollView addSubview:detailLabel];
    detailLabel.backgroundColor = [UIColor whiteColor];
    detailLabel.layer.borderWidth = 0.3f;
    detailLabel.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    
    
    /**反馈内容*/
    TCTextView *textView = [[TCTextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(detailLabel.frame), ApplicationframeValue.width, 100)];
    textView.placeholder = @"乐意聆听您对天巢手机客户端的任何建议";
    [scrollView addSubview:textView];
    self.textView = textView;
    
    /**联系方式*/
    UILabel *connectLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textView.frame)+15, ApplicationframeValue.width, 45)];
    connectLabel.text = @"  联系方式";
    connectLabel.textAlignment = NSTextAlignmentLeft;
    connectLabel.layer.borderWidth = 0.3f;
    connectLabel.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    connectLabel.font = AppFont(15);
    [scrollView addSubview:connectLabel];
    connectLabel.backgroundColor = [UIColor whiteColor];
    /**手机号码*/
    
    
    UIView *PhoneView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(connectLabel.frame), ApplicationframeValue.width, 45)];
    PhoneView.backgroundColor = [UIColor whiteColor];
    self.PhoneView = PhoneView;
    [scrollView addSubview:PhoneView];
    
    UITextField *PhoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(8, 0, ApplicationframeValue.width-20, 45)];
    PhoneTextField.backgroundColor = [UIColor whiteColor];
    PhoneTextField.placeholder = @"手机号码或邮箱（选填）";
    PhoneTextField.font = AppFont(13);
    PhoneTextField.delegate = self;
    PhoneTextField.clearButtonMode = UITextFieldViewModeAlways;
    [PhoneView addSubview:PhoneTextField];
    self.PhoneTextField = PhoneTextField;
    
    /**提交按钮*/
    UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, ApplicationframeValue.height-45, ApplicationframeValue.width, 45)];
    [self.view addSubview:submitBtn];
    submitBtn.backgroundColor = AppColor;
    NSLog(@"height:%f",ApplicationframeValue.height);
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.titleLabel.textColor = AppColor;
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    submitBtn.titleLabel.font = AppFont(14);
    
}


-(void)Onclick:(UIButton *)sender{
    sender.selected = !sender.selected;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    
}

@end
