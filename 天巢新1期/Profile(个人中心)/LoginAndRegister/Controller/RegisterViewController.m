//
//  RegisterViewController.m
//  天巢新1期
//
//  Created by 赵贺 on 15/12/17.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "RegisterViewController.h"
#import "CountDownButton.h"
#import "Utils.h"
@interface RegisterViewController ()<UITextFieldDelegate>
/**手机号*/
@property (nonatomic,strong)UITextField *phoneText;
/**验证码*/
@property (nonatomic,strong)UITextField *yanzhengma;
/**密码*/
@property (nonatomic,strong)UITextField *passwordText;
/**确认密码*/
@property (nonatomic,strong)UITextField *FpasswordText;
@property (nonatomic,strong)CountDownButton *countDown;
@end

@implementation RegisterViewController
-(void)viewDidLoad
{

    UIView *registerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ApplicationframeValue.width, ApplicationframeValue.height-64)];
    [self.view addSubview:registerView];
    
    
    UIImageView *usersImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile_icon_yijianfankui"]];
    usersImage.frame = CGRectMake(20, 10, 40, 40);
    [registerView addSubview:usersImage];
    
    /**手机号*/
    UITextField *phoneText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(usersImage.frame), usersImage.origin.y, ApplicationframeValue.width-2*usersImage.origin.x-usersImage.width, usersImage.height)];
    [registerView addSubview:phoneText];
    phoneText.delegate = self;
    phoneText.placeholder = @"11位手机号";
    phoneText.font = AppFont(12);
    self.phoneText = phoneText;

    
    
    UIImageView *yanzhengmaImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile_icon_yijianfankui"]];
    yanzhengmaImage.frame = CGRectMake(20, CGRectGetMaxY(usersImage.frame)+10, 40, 40);
    [registerView addSubview:yanzhengmaImage];
    
    
    /**验证码*/
    UITextField *yanzhengma = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(yanzhengmaImage.frame), yanzhengmaImage.origin.y, ApplicationframeValue.width-2*yanzhengmaImage.origin.x-yanzhengmaImage.width-80, yanzhengmaImage.height)];
    [registerView addSubview:yanzhengma];
    yanzhengma.delegate = self;
    yanzhengma.placeholder = @"验证码";
    yanzhengma.font = AppFont(12);
    self.yanzhengma = yanzhengma;
    
    /**发送*/
    
   self.countDown  = [[CountDownButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(yanzhengma.frame), yanzhengmaImage.y, 80, yanzhengmaImage.height)];
    [registerView addSubview:self.countDown];
#warning 发送验证码
    
    [self.countDown addTarget:self action:@selector(CountDown) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    

    
    UIImageView *passwordImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile_icon_yijianfankui"]];
    passwordImage.frame = CGRectMake(20, CGRectGetMaxY(yanzhengmaImage.frame)+10, 40, 40);
    [registerView addSubview:passwordImage];
/**密码*/
    UITextField *passwordText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(passwordImage.frame), passwordImage.origin.y, ApplicationframeValue.width-2*passwordImage.origin.x-passwordImage.width, passwordImage.height)];
    [registerView addSubview:passwordText];
    passwordText.delegate = self;
    passwordText.placeholder = @"6-16位字母和数字";
    passwordText.font = AppFont(12);
    
    self.passwordText = passwordText;
    
    
    
    UIImageView *FpasswordImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile_icon_yijianfankui"]];
    FpasswordImage.frame = CGRectMake(20, CGRectGetMaxY(passwordImage.frame)+10, 40, 40);
    [registerView addSubview:FpasswordImage];
    /**密码*/
    UITextField *FpasswordText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(FpasswordImage.frame), FpasswordImage.origin.y, ApplicationframeValue.width-2*FpasswordImage.origin.x-FpasswordImage.width, FpasswordImage.height)];
    [registerView addSubview:FpasswordText];
    FpasswordText.delegate = self;
    FpasswordText.placeholder = @"请再次确认密码";
    FpasswordText.font = AppFont(12);
    
    self.FpasswordText = FpasswordText;
    
    
    
    
    
    
    /**横线*/
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(usersImage.origin.x+10, usersImage.origin.y+usersImage.size.height, ApplicationframeValue.width-2*usersImage.origin.x-20, 0.4f)];
    lineView.backgroundColor = [Color_LightGray colorWithAlphaComponent:0.5f];
    [registerView addSubview:lineView];
    
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(yanzhengmaImage.origin.x+10, yanzhengmaImage.origin.y+yanzhengmaImage.size.height, ApplicationframeValue.width-2*yanzhengmaImage.origin.x-20, 0.4f)];
    lineView2.backgroundColor = [Color_LightGray colorWithAlphaComponent:0.5f];
    [registerView addSubview:lineView2];
    
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(passwordImage.origin.x+10, passwordImage.origin.y+passwordImage.size.height, ApplicationframeValue.width-2*passwordImage.origin.x-20, 0.4f)];
    lineView3.backgroundColor = [Color_LightGray colorWithAlphaComponent:0.5f];
    [registerView addSubview:lineView3];

    
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(FpasswordImage.origin.x+10, FpasswordImage.origin.y+FpasswordImage.size.height, ApplicationframeValue.width-2*FpasswordImage.origin.x-20, 0.4f)];
    lineView4.backgroundColor = [Color_LightGray colorWithAlphaComponent:0.5f];
    [registerView addSubview:lineView4];

    
    
    /**注册*/
    
    UIButton *registerBtn  = [[UIButton alloc] initWithFrame:CGRectMake(lineView4.origin.x+15, lineView4.origin.y+30, lineView4.width-30, 30)];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = AppFont(13);
    [registerBtn addTarget: self action:@selector(registerNow) forControlEvents:UIControlEventTouchUpInside];
    [registerView addSubview:registerBtn];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn setBackgroundColor:AppColor];
    


}

/**发送验证码*/
-(void)CountDown{
    if (!self.phoneText.text.length) {
        AlertLog(nil, @"请输入您的手机号", @"确定", nil);
        return ;
    }
    
    /**正则表达式验证手机格式*/
    BOOL isMatch = [Utils checkTelNumber:self.phoneText.text];
    if (!isMatch) {
        AlertLog(nil, @"您输入的手机号码格式不正确", @"确定", nil);
        return ;
    }
    /**判断是否已经注册*/
    NSString *userName = [[SharedInstance sharedInstance]getPhoneNumber];
    if ([userName isEqualToString:self.phoneText.text]) {
        AlertLog(nil, @"您输入的手机号码已注册", @"确定", nil);
        return;
    }
    
    [self.countDown beginCountDown];
    /**发送验证码*/
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneText.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (error) {
            NSLog(@"error %@", error);
        }else{
            NSLog(@"验证码发送成功");
        }
    }];
    
}


-(void)registerNow{
    
    /**验证码校验*/
    if (!self.yanzhengma.text.length){
        
        AlertLog(nil, @"请输入验证码", @"确定", nil);
        return ;
        
    }
    
    if (!self.passwordText.text.length) {
        AlertLog(nil, @"请输入密码", @"确定", nil);
        return;
    }
    /**验证输入的密码6-18位*/
    BOOL codeMatched  = [Utils checkPassword:self.passwordText.text];
    
    if (!codeMatched) {
        AlertLog(nil, @"请输入6-16位字母与数字组合的密码", @"确定", nil);
        return;
    }
    
    if (!self.FpasswordText.text.length) {
        AlertLog(nil, @"请再次确认密码", @"确定", nil);
        return;

    }
    
    
    if (![self.passwordText.text isEqualToString:self.FpasswordText.text]) {
        
        [self.countDown stop];
        AlertLog(nil, @"两次输入的密码不同", @"确定", nil);
        return;
        
    }
    
    
    [SMSSDK commitVerificationCode:self.yanzhengma.text phoneNumber:self.phoneText.text zone:@"86" result:^(NSError *error) {
        if (error) {
            NSLog(@"验证码不正确 %@", error);
            AlertLog(nil, @"验证码不正确", @"确定", nil);
            //倒计时停止，重新发送
            [self.countDown stop];
            
        }else{
            NSLog(@"验证码正确");
            [self.countDown stop];
            
            //在此存储手机号和密码，进入个人中心
            
            [[SharedInstance sharedInstance] setPhoneNumber:self.phoneText.text];
            [[SharedInstance sharedInstance] setPassword:self.passwordText.text];
            
            
            //标记已经登录
            [SharedInstance sharedInstance].alreadyLanded = YES;
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            
        }
    }];

    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [textField resignFirstResponder];
    return YES;
}



@end
