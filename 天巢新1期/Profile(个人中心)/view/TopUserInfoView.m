//
//  TopUserInfoView.m
//  天巢新1期
//
//  Created by 赵贺 on 15/12/16.
//  Copyright © 2015年 tangjp. All rights reserved.


//个人中心顶部视图
#import "TopUserInfoView.h"

#define HeaderViewWidth ApplicationframeValue.width/4

@interface TopUserInfoView ()



@end




@implementation TopUserInfoView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor lightGrayColor];
    /**顶部背景图*/
    UIImageView *aboveView = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"homePage_1.png"]];
    aboveView.frame = self.frame;
    [self addSubview:aboveView];

    
//**如果已经登录
    
    if ([SharedInstance sharedInstance].alreadyLanded) {
    
    //**头像
    self.headerView =[[UIImageView alloc]initWithImage:[UIImage imageNamed: @"homePage_1.png"]];
    self.headerView.frame = CGRectMake(10, TopHeight-HeaderViewWidth-5-35, HeaderViewWidth, HeaderViewWidth);

    self.headerView.backgroundColor = Color(245, 58, 64);
    self.headerView.layer.cornerRadius = HeaderViewWidth/2;
    [self.headerView.layer setBorderWidth:0.0f];
    [self addSubview:self.headerView];

    
    //**用户名
    self.nameL = [[UILabel alloc]initWithFrame:CGRectMake(self.headerView.frame.size.width, self.headerView.centerY-30, 200, 35)];
    self.nameL.textAlignment = NSTextAlignmentCenter;
    self.nameL.textColor = Color(245, 58, 64);
    self.nameL.font = AppFont(14.0f);
        
        
    self.nameL.text = [[SharedInstance sharedInstance] getUserName];
    [self addSubview:self.nameL];
        
        
   /**完善个人资料*/
        
        UIView *detailView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headerView.origin.y+self.headerView.height+5, ApplicationframeValue.width, 35)];
        
        detailView.backgroundColor = AppColor;
        [self addSubview:detailView];
        self.detailView = detailView;
        UILabel *personalLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 35)];
        personalLabel.textColor = [UIColor whiteColor];
        personalLabel.text = @"完善个人资料";
        personalLabel.font = AppFont(14.0f);

        [detailView addSubview:personalLabel];
        

        
        
        
    
    }
    
    /**如果没有登录   显示登录和注册选项*/
    else{
        [self.headerView removeFromSuperview];
        [self.nameL removeFromSuperview];
        
        self.headerView =[[UIImageView alloc]initWithImage:[UIImage imageNamed: @"homePage_1.png"]];
        CGPoint center = self.headerView.center;
        center.x  = self.bounds.size.width/2-HeaderViewWidth/2;
        
        center.y  = self.height/2-50;
        self.headerView.center = center;
        self.headerView.size = CGSizeMake(HeaderViewWidth, HeaderViewWidth);
        self.headerView.backgroundColor = Color(245, 58, 64);
        self.headerView.layer.cornerRadius = HeaderViewWidth/2;
        [self.headerView.layer setBorderWidth:0.0f];
        [self addSubview:self.headerView];
    
        /**登录按钮*/
    
        UIButton *loginBtn  = [[UIButton alloc] initWithFrame:CGRectMake(ApplicationframeValue.width/2-41, self.headerView.origin.y+self.headerView.height+10, 40, 20)];
        self.loginBtn = loginBtn;
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        loginBtn.backgroundColor = AppColor;
        loginBtn.titleLabel.font = AppFont(12);
        [self addSubview:loginBtn];
        
        
        /**竖线*/
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(ApplicationframeValue.width/2, loginBtn.origin.y, 0.5, 20)];
        [self addSubview:lineView];
        lineView.backgroundColor = [UIColor blackColor];
        
        /**注册按钮*/
        UIButton *registerBtn  = [[UIButton alloc] initWithFrame:CGRectMake(ApplicationframeValue.width/2+1, loginBtn.origin.y, 40, 20)];
        self.registerBtn = registerBtn;
//        registerBtn.backgroundColor = AppColor;
        [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        registerBtn.titleLabel.font = AppFont(12);
        [self addSubview:registerBtn];
 
    }
    
    /**设置按钮*/
    
    self.settingButton = [[UIButton alloc] initWithFrame:CGRectMake(ApplicationframeValue.width-65, 10, 50, 20)];
    [self.settingButton setTitle:@"设置" forState:UIControlStateNormal];
    self.settingButton.layer.cornerRadius = 10;
    self.settingButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.settingButton.titleLabel.font = AppFont(12.0f);
    self.settingButton.backgroundColor = Color(245, 58, 64);
    [self.settingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [self addSubview:self.settingButton];
    
    
    
    
    return self;
}




@end
