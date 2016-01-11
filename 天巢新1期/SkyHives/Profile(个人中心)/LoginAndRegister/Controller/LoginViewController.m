//
//  LoginViewController.m
//  天巢新1期
//
//  Created by 赵贺 on 15/12/17.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "LoginViewController.h"
#import "CustomerView.h"
#import "RegisterViewController.h"
#import "NSString+Hash.h"
#import "Utils.h"
#import "NSData+AESEncryption.h"
#import "SecurityUtil.h"



@interface LoginViewController ()<CustomerDelegate,UITextFieldDelegate>
@property (nonatomic,strong)UIView *loginView;
@property (nonatomic,strong)UIView *registerView;

@property (nonatomic,strong)UITextField *userText;
@property (nonatomic,strong)UITextField *passwordText;

@end

@implementation LoginViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CustomerView *topView = [[CustomerView alloc] initWithFrame:CGRectMake(0, 64, ApplicationframeValue.width, 47) initButWithArray:@[@"手机登录",@"账号登录"] butFont:15 selectedIndex:0];
    topView.delegate = self;
    [self.view addSubview:topView];
    
    
    UIView *loginView = [[UIView alloc] initWithFrame:CGRectMake(0, topView.origin.y+topView.height, ApplicationframeValue.width, ApplicationframeValue.height-44)];
    loginView.backgroundColor = [UIColor lightGrayColor];
    UIImageView *userImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile_icon_yijianfankui"]];
    userImage.frame = CGRectMake(30, 30, 20, 20);
    [loginView addSubview:userImage];
    self.loginView = loginView;
    
    
    
    
    
    UIView *registerView = [[UIView alloc] initWithFrame:CGRectMake(0, topView.origin.y+topView.height, ApplicationframeValue.width, ApplicationframeValue.height-44)];
    registerView.backgroundColor = [UIColor whiteColor];
    UIImageView *usersImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile_icon_yijianfankui"]];
    usersImage.frame = CGRectMake(30, 30, 40, 40);
    //    usersImage.backgroundColor = AppColor;
    [registerView addSubview:usersImage];
    
    
    
    UITextField *userText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(usersImage.frame), usersImage.origin.y, ApplicationframeValue.width-2*usersImage.origin.x-usersImage.width, usersImage.height)];
    [registerView addSubview:userText];
    userText.delegate = self;
    userText.placeholder = @"邮箱/用户名/手机号";
    self.userText = userText;
    userText.font = AppFont(12);
    
    
    UIImageView *passwordImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile_icon_yijianfankui"]];
    passwordImage.frame = CGRectMake(30, 30+50, 40, 40);
    //    usersImage.backgroundColor = AppColor;
    [registerView addSubview:passwordImage];
    
    UITextField *passwordText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(passwordImage.frame), passwordImage.origin.y, ApplicationframeValue.width-2*passwordImage.origin.x-passwordImage.width, passwordImage.height)];
    [registerView addSubview:passwordText];
    passwordText.delegate = self;
    passwordText.placeholder = @"请输入密码";
    passwordText.secureTextEntry = YES;
    
    self.passwordText = passwordText;
    passwordText.font = AppFont(12);
    
    
    
    
    /**横线*/
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(usersImage.origin.x+10, usersImage.origin.y+usersImage.size.height, ApplicationframeValue.width-2*usersImage.origin.x, 0.4f)];
    lineView.backgroundColor = [Color_LightGray colorWithAlphaComponent:0.5f];
    [registerView addSubview:lineView];
    
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(passwordImage.origin.x+10, passwordImage.origin.y+passwordImage.size.height, ApplicationframeValue.width-2*passwordImage.origin.x, 0.4f)];
    lineView2.backgroundColor = [Color_LightGray colorWithAlphaComponent:0.5f];
    [registerView addSubview:lineView2];
    
    
    UIButton *forgetPassword = [[UIButton alloc] initWithFrame:CGRectMake(lineView2.origin.x, CGRectGetMaxY(lineView2.frame) , 70, 30)];
    
    [registerView addSubview:forgetPassword];
    [forgetPassword setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetPassword setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    forgetPassword.titleLabel.font = AppFont(11);
    forgetPassword.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    CGFloat buttonW = (ApplicationframeValue.width-3*forgetPassword.origin.x)/2;
    
    
    
    /**登录按钮*/
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(forgetPassword.origin.x, CGRectGetMaxY(forgetPassword.frame)+30, buttonW, 30)];
    
    [registerView addSubview:loginBtn];
    [loginBtn setBackgroundColor:AppColor];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = AppFont(13);
    
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    /**注册按钮*/
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMidX(loginBtn.frame) +buttonW, loginBtn.origin.y, buttonW, 30)];
    
    [registerView addSubview:registerBtn];
    [registerBtn setBackgroundColor:[UIColor whiteColor]];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:AppColor forState:UIControlStateNormal];
    registerBtn.titleLabel.font = AppFont(13);
    registerBtn.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f].CGColor;
    [registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.layer.borderWidth = 0.4f;
    
    
    [self.view addSubview:registerView];
    self.registerView = registerView;
    //    [self.view addSubview:loginView];
    
    
    
}


#pragma mark - CustomerView Delegate

-(void)OnclickCustomerTag:(NSInteger)customerTag
{
    
    
    switch (customerTag) {
        case 1:
            [self.view bringSubviewToFront:self.registerView];
            break;
        case 2:
            [self.view bringSubviewToFront:self.registerView];
            
            break;
            
            
    }
    
    
    
}

#pragma mark - 点击登录
-(void)login{
    
    if (!self.userText.text.length) {
        //        AlertLog(nil, @"请输入手机号码", @"确定", nil);
        [self showErrorMsg:@"请输入手机号码"];
        return ;
    }
    if (!self.passwordText.text.length) {
        //        AlertLog(nil, @"请输入密码", @"确定", nil);
        [self showErrorMsg: @"请输入密码"];
        return ;
    }

    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    
    
    // 2. 拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    

    
    

    
    NSString *originString = [NSString stringWithFormat:@"{account:'%@',password:'%@',time:'%@',random:'%@'}",self.userText.text,self.passwordText.text.md5String,currentDateStr,@"258258"];

    NSData *data = [SecurityUtil encryptAESWithString:originString];
    NSString *str = [NSString hexStringForData:data];
    
    params[@"code"] = str;
    
    
    [mgr GET:@"http://192.168.1.154:8080/zp/userbehaviorapi/loginApp?" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        NSNumber *status = responseObject[@"status"];
        
        NSLog(@"%@",status);
        
        NSLog(@"%@",responseObject);
        
        if ([status isEqualToNumber:@1]) {
            [self showSuccessMsg:@"登陆成功"];
            
            //在此存储手机号和密码，进入个人中心
            [[SharedInstance sharedInstance] setPhoneNumber:self.userText.text];
            [[SharedInstance sharedInstance] setPassword:self.passwordText.text];
            
            //标记已经登录
            [SharedInstance sharedInstance].alreadyLanded = YES;
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error===%@",error);
        [self showErrorMsg:@"登录失败,等会儿再试"];
    }];
}





#pragma mark - 注册
-(void)registerClick{
    
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
    
}



#pragma mark - textFieldDelegate
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    NSString *secret = @"{account:'13416137382',password:'5a854bedc4ceb10e33acbab3552b58f9',time:'201501111144',random:'654321'}";

    //加密
    NSString *encryptDate=[SecurityUtil encryptAESData:secret];
    NSLog(@"base64EncryptDate %@",encryptDate);
    
    //解密
    NSString *decodeData=[SecurityUtil decryptAESData:[SecurityUtil encryptAESData:secret]];
    NSLog(@"decodeData %@",decodeData);
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}

@end
