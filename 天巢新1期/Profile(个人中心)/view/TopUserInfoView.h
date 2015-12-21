//
//  TopUserInfoView.h
//  天巢新1期
//
//  Created by 赵贺 on 15/12/16.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopUserInfoView : UIView
/**头像*/
@property (nonatomic,strong)UIImageView *headerView;
/**用户名*/
@property(nonatomic,strong)UILabel *nameL;
/**设置按钮*/
@property (nonatomic,strong)UIButton *settingButton;

/**完善个人资料*/
@property (nonatomic,strong)UIView *detailView;
/**登录按钮*/
@property (nonatomic,strong)UIButton *loginBtn;
/**注册按钮*/
@property (nonatomic,strong)UIButton *registerBtn;
@end
