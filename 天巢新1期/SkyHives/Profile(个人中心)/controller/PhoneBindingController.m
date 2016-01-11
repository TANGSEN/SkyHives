//
//  PhoneBindingController.m
//  天巢新1期
//
//  Created by 赵贺 on 15/12/18.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "PhoneBindingController.h"
#import "Utils.h"

@interface PhoneBindingController ()
@property (nonatomic,strong)UITextField *textField;
@end

@implementation PhoneBindingController
-(void)viewDidLoad
{

    [super viewDidLoad];
    self.view.backgroundColor = View_BgColor;
    self.title = @"绑定手机";
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 30+64, ApplicationframeValue.width, 60)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.4f].CGColor;
    view.layer.borderWidth = 0.5f;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, view.height)];
    [view addSubview:label];
    label.text = @"当前手机号:";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = AppFont(14);
    
    
    UITextField *textField  = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+10, 0, ApplicationframeValue.width-label.width-20-80, view.height)];
    [view addSubview:textField];
    self.textField = textField;
    textField.text = [SharedInstance sharedInstance].getPhoneNumber;
    textField.font = AppFont(13);
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UIButton *bindingBtn = [[UIButton alloc] initWithFrame:CGRectMake(ApplicationframeValue.width-80, 15, 70, 30)];
    [view addSubview:bindingBtn];
    bindingBtn.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f].CGColor;
    bindingBtn.layer.borderWidth = 0.5f;
    [bindingBtn setTitle:@"重新绑定" forState:UIControlStateNormal];
    [bindingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    bindingBtn.titleLabel.font = AppFont(13);
    [bindingBtn addTarget:self action:@selector(binding) forControlEvents:UIControlEventTouchUpInside];
    
    
    


}


-(void)binding{
    /**正则表达式验证手机格式*/
    BOOL isMatch = [Utils checkTelNumber:self.textField.text];
    if (!isMatch) {
        AlertLog(nil, @"您输入的手机号码格式不正确", @"确定", nil);
        return ;
    }
    /**判断是否已经注册*/
    NSString *PhoneNumber = [[SharedInstance sharedInstance]getPhoneNumber];
    if ([PhoneNumber isEqualToString:self.textField.text]) {
        AlertLog(nil, @"您输入的手机号码已注册", @"确定", nil);
        return;
    }
    
    
    [[SharedInstance sharedInstance] setPhoneNumber:self.textField.text];
    
    [self.navigationController popViewControllerAnimated:YES];

    
    
    
    
    
}
@end
