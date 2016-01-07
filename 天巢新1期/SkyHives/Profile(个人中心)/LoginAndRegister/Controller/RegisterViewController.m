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
#import "NSString+Hash.h"

/*
 发送短信验证码
 接口	http://www.skyhives.com /zp/userbehaviorapi/sendCode
 输入参数	telphone (电话号码)
 返
 回
 值	status（发送状态:1 成功 0 失败）
	data（返回数据）
	msg(消息提示)
 例子	以13416137382注册为例
 http://www.skyhives.com/zp/userbehaviorapi/sendCode?telephone=13416137382
 
 
 检验短信验证码是否正确
 接口	http:// www.skyhives.com/m/chkcode
 输入参数	telphone (电话号码)
	random (验证码)
 返
 回
 值	status（发送状态:1 成功 0 失败）
	data（返回数据）
	msg(消息提示)
 例子	以13416137382注册为例
 http://www.skyhives.com/m/chkcode?telphone=13416137382&&random=123456
 
 注册用户
 接口	http://www.skyhives.com/m/regp
 输入参数	tel(电话)
	rsa(登录密码,用MD5 32位加密)
	tpwd(交易密码，用MD5 32位加密)
	Level(登录密码强度)
	level2(交易密码强度)密码强度的实现算法见4.1
 返
 回
 值	status（注册状态:1 成功 0 失败）
	data（返回数据）
	msg(消息提示)
 例子	http:// www.skyhives.com/m/regp?tel=13416137382&&rsa= e10adc3949ba59abbe56e057f20f883e&& tpwd= e10adc3949ba59abbe56e057f20f883e&&level=2&&level2=3
 注意	注册前请校验手机验证码，图片验证码
 */

@interface RegisterViewController ()<UITextFieldDelegate, NSURLConnectionDataDelegate>
/**手机号*/
@property (nonatomic,strong)UITextField *phoneText;
/**验证码*/
@property (nonatomic,strong)UITextField *yanzhengma;
/**密码*/
@property (nonatomic,strong)UITextField *passwordText;
/**确认密码*/
@property (nonatomic,strong)UITextField *FpasswordText;

/**支付密码*/
@property (nonatomic,strong)UITextField *TpasswordText;
/**确认支付密码*/
@property (nonatomic,strong)UITextField *TFpasswordText;
@property (nonatomic,strong)CountDownButton *countDown;

@property (nonatomic ,strong) NSMutableData *jpData;

@end

@implementation RegisterViewController

- (NSMutableData *)jpData{
    if (!_jpData){
        _jpData = [[NSMutableData alloc]init];
    }
    return _jpData;
}

-(void)viewDidLoad
{

    self.view.backgroundColor = [UIColor whiteColor];

    
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
    
    UIImageView *TpasswordImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile_icon_yijianfankui"]];
    TpasswordImage.frame = CGRectMake(20, CGRectGetMaxY(FpasswordImage.frame)+10, 40, 40);
    [registerView addSubview:TpasswordImage];
    /**支付密码*/
    UITextField *TpasswordText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(TpasswordImage.frame), TpasswordImage.origin.y, ApplicationframeValue.width-2*TpasswordImage.origin.x-TpasswordImage.width, TpasswordImage.height)];
    [registerView addSubview:TpasswordText];
    TpasswordText.delegate = self;
    TpasswordText.placeholder = @"请设置您的交易密码";
    TpasswordText.font = AppFont(12);
    
    self.TpasswordText = TpasswordText;
    
    UIImageView *TFpasswordImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile_icon_yijianfankui"]];
    TFpasswordImage.frame = CGRectMake(20, CGRectGetMaxY(TpasswordImage.frame)+10, 40, 40);
    [registerView addSubview:TFpasswordImage];
    /**确认支付密码*/
    UITextField *TFpasswordText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(TFpasswordImage.frame), TFpasswordImage.origin.y, ApplicationframeValue.width-2*TFpasswordImage.origin.x-TFpasswordImage.width, TFpasswordImage.height)];
    [registerView addSubview:TFpasswordText];
    TFpasswordText.delegate = self;
    TFpasswordText.placeholder = @"请确认您的交易密码";
    TFpasswordText.font = AppFont(12);
    
    self.TFpasswordText = TFpasswordText;
    
    
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

    UIView *lineView5 = [[UIView alloc] initWithFrame:CGRectMake(TpasswordImage.origin.x+10, TpasswordImage.origin.y+TpasswordImage.size.height, ApplicationframeValue.width-2*TpasswordImage.origin.x-20, 0.4f)];
    lineView5.backgroundColor = [Color_LightGray colorWithAlphaComponent:0.5f];
    [registerView addSubview:lineView5];
    
    
    UIView *lineView6 = [[UIView alloc] initWithFrame:CGRectMake(TFpasswordImage.origin.x+10, TFpasswordImage.origin.y+TFpasswordImage.size.height, ApplicationframeValue.width-2*TFpasswordImage.origin.x-20, 0.4f)];
    lineView6.backgroundColor = [Color_LightGray colorWithAlphaComponent:0.5f];
    [registerView addSubview:lineView6];

    
    /**注册*/
    UIButton *registerBtn  = [[UIButton alloc] initWithFrame:CGRectMake(lineView6.origin.x+15, lineView6.origin.y+30, lineView6.width-30, 30)];
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
    
    [self.countDown beginCountDown];
    /**  SMSSDK发送验证码  */
   /* [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneText.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (error) {
            NSLog(@"error %@", error);
        }else{
            NSLog(@"验证码发送成功");
        }
    }]; */
    
    [JPNetWork POST:@"http://www.skyhives.com/userbehaviorapi/sendCode?" parameters:@{@"telphone":self.phoneText.text} completionHandler:^(NSDictionary *responseObj, NSError *error) {
        NSNumber *statusCode = responseObj[@"status"];
        if ([statusCode isEqualToNumber:@0]) {
            [self showErrorMsg:responseObj[@"msg"]];
            [self.countDown stop];
        }else if ([statusCode isEqualToNumber:@1]){
            [self showSuccessMsg:responseObj[@"msg"]];
        }
        
        if (error) {
            if (error.code == -1001) {
                [self showErrorMsg:@"请求超时,请重试"];
            }else{
                [self showErrorMsg:[NSString stringWithFormat:@"服务器返回错误%ld",error.code]];
            }
            [self.countDown stop];
        }
        
    }];
    
    /* 原生 POST请求
    // POST请求
    NSString *urlString = @"http://www.skyhives.com/userbehaviorapi/sendCode?";
    // 创建url对象
    NSURL *url = [NSURL URLWithString:urlString];
    // 创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    // 创建参数字符串对象
    NSString *parmStr = [NSString stringWithFormat:@"telphone=%@",self.phoneText.text];
    // 将字符串转换为NSData对象
    NSData *data = [parmStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    [request setHTTPMethod:@"POST"];
    // 创建异步连接（形式二）
    [NSURLConnection connectionWithRequest:request delegate:self];
    */
}

/* 原生请求代理方法
// 服务器接收到请求时
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
}
// 当收到服务器返回的数据时触发, 返回的可能是资源片段
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.jpData appendData:data];
}
// 当服务器返回所有数据时触发, 数据返回完毕
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *string = [[NSString alloc]initWithData:self.jpData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",string);
}
// 请求数据失败时触发
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%s", __FUNCTION__);
    
    NSLog(@"error===%@",error);
}
 */

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
    
    if (!self.TpasswordText.text.length) {
        AlertLog(nil, @"请设置六位数字支付密码", @"确定", nil);
        return;
    }
    
    if (!self.TFpasswordText.text.length) {
        AlertLog(nil, @"请确认支付密码", @"确定", nil);
        return;
    }
    
    [JPNetWork POST:@"http://www.skyhives.com/m/chkcode" parameters:@{@"telphone":self.phoneText.text,@"random":self.yanzhengma.text} completionHandler:^(NSDictionary * responseObj, NSError *error) {
        NSLog(@"responseObj===%@",responseObj);
        NSLog(@"error===%ld",error.code);
        if (error) {
            if (error.code == -1001) {
                [self showErrorMsg:@"请求超时"];
            }else if (error.code == 3804){
                [self showErrorMsg:@"服务器错误"];
            }else{
                AlertLog(nil, @"验证码不正确", @"确定", nil);
            }
            //倒计时停止，重新发送
            [self.countDown stop];

        }else{
            NSLog(@"验证码正确");
            [self.countDown stop];
            [self sendRegp];
            //在此存储手机号和密码，进入个人中心
            [[SharedInstance sharedInstance] setPhoneNumber:self.phoneText.text];
            [[SharedInstance sharedInstance] setPassword:self.passwordText.text];

            //标记已经登录
            [SharedInstance sharedInstance].alreadyLanded = YES;
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
    /*  SMSSDK验证码效验
    [SMSSDK commitVerificationCode:self.yanzhengma.text phoneNumber:self.phoneText.text zone:@"86" result:^(NSError *error) {
        if (error) {
            NSLog(@"验证码不正确 %@", error);
            AlertLog(nil, @"验证码不正确", @"确定", nil);
            //倒计时停止，重新发送
            [self.countDown stop];
            
        }else{
            NSLog(@"验证码正确");
            [self.countDown stop];
            [self sendRegp];
            //在此存储手机号和密码，进入个人中心
            [[SharedInstance sharedInstance] setPhoneNumber:self.phoneText.text];
            [[SharedInstance sharedInstance] setPassword:self.passwordText.text];
            
            //标记已经登录
            [SharedInstance sharedInstance].alreadyLanded = YES;
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
     */
}

// 发送注册消息
- (void)sendRegp {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2. 拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"tel"] = self.phoneText.text;
    /**
     *  此处用到了NSString+Hash分类,
     */
    params[@"rsa"] = [self.FpasswordText.text md5String];
    params[@"tpwd"] = [self.TFpasswordText.text md5String];
    params[@"level"] = @2;
    params[@"level2"] = @2;
    [mgr POST:@"http://www.skyhives.com/m/regp" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"注册成功");
        NSLog(@"responseObject -- -- %@",responseObject);
        [self showSuccessMsg:@"注册成功"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showErrorMsg:@"注册失败,等会儿再试"];
        NSLog(@"error -- -- %@",error);
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
