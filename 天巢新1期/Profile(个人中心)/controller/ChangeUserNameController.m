//
//  ChangeUserNameController.m
//  天巢新1期
//
//  Created by 赵贺 on 15/12/18.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "ChangeUserNameController.h"


@interface ChangeUserNameController ()
@property (nonatomic,strong)UITextField *textField;
@end

@implementation ChangeUserNameController

-(void)viewDidLoad
{
    
    self.view.backgroundColor = View_BgColor;
    self.title = @"修改用户名";
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 30+64, ApplicationframeValue.width, 60)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.4f].CGColor;
    view.layer.borderWidth = 0.5f;

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 50, view.height)];
    [view addSubview:label];
    label.text = @"用户名";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = AppFont(14);
    
    
    UITextField *textField  = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+10, 0, ApplicationframeValue.width-label.width-20, view.height)];
    [view addSubview:textField];
    self.textField = textField;
    textField.text = [SharedInstance sharedInstance].getUserName;
    textField.font = AppFont(13);
    textField.clearButtonMode = UITextFieldViewModeAlways;
    
    

}

-(void)save{
    [[SharedInstance sharedInstance] setUserName:self.textField.text];

    [self.navigationController popViewControllerAnimated:YES];
    
    
}
@end
