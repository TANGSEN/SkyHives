//
//  SettingViewController.m
//  天巢新1期
//
//  Created by 赵贺 on 15/12/16.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "SettingViewController.h"
#import "PersonalViewController.h"
#import "LoginViewController.h"
#import "AddressViewController.h"




@interface SettingViewController ()<UIAlertViewDelegate>
@property (nonatomic,strong)NSArray *Titles;
@end

@implementation SettingViewController



-(void)viewDidLoad
{
    
    self.tableView.tableFooterView = FooterView;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.Titles  = [SharedInstance sharedInstance].alreadyLanded? @[@"个人资料",@"收货地址管理",@"关于天巢",@"退出账号"]:@[@"个人资料",@"收货地址管理",@"关于天巢"];
    [self.tableView reloadData];
    
}

#pragma mark - tableView dataSoucre
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.Titles.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell  = [[UITableViewCell alloc] init];
    cell.textLabel.text = self.Titles[indexPath.row];
    
    if (![SharedInstance sharedInstance].alreadyLanded) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.row!=self.Titles.count-1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = AppFont(13.0f);
    return cell;
}


#pragma mark - tableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 15.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *obj = nil;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: nil
                                                        message: @"确定退出当前账号吗？"
                                                       delegate: nil
                                              cancelButtonTitle: @"确定"
                                              otherButtonTitles: @"取消",
                              nil];
    alertView.delegate = self;
    switch (indexPath.row) {
        case 0:
            NSLog(@"点击了%@",self.Titles[indexPath.row]);
            if (![[SharedInstance  sharedInstance] alreadyLanded]) {
                
                obj = [[LoginViewController alloc] init];
                [self.navigationController pushViewController:obj animated:YES];
                
                
            }else{
                
                obj = [[PersonalViewController alloc] init];
                [self.navigationController pushViewController:obj animated:YES];
                
            }
            break;
        case 1:
            if (![[SharedInstance  sharedInstance] alreadyLanded]) {
                
                obj = [[LoginViewController alloc] init];
                [self.navigationController pushViewController:obj animated:YES];
                
                
            }else{
                
                obj = [[AddressViewController alloc] init];
                [self.navigationController pushViewController:obj animated:YES];
                
            }
            break;
        case 2:
            NSLog(@"点击了%@",self.Titles[indexPath.row]);
            
            break;
        case 3:
            
            [alertView show];
            
            break;
            
        default:
            break;
            
            
    }
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0) {
        
        [UIView  animateWithDuration:0.2 animations:^{
            
            //            1、每次注销应该清除账号信息
            //            2、每次登录应该与服务器验证（防止在其他客户端登录 修改信息）
            [[SharedInstance sharedInstance] clearAllData];
            
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        
        
    }
    
    
}

@end
