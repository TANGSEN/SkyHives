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
@interface SettingViewController ()
@property (nonatomic,strong)NSArray *Titles;
@end

@implementation SettingViewController



-(void)viewDidLoad
{

    self.tableView.tableFooterView = FooterView;


}
-(NSArray *)Titles
{

    if (!_Titles) {
        _Titles  = [SharedInstance sharedInstance].alreadyLanded? @[@"个人资料",@"收货地址管理",@"关于天巢",@"退出账号"]:@[@"个人资料",@"收货地址管理",@"关于天巢"];
    }
    return _Titles;
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
    
    switch (indexPath.row) {
        case 0:
            NSLog(@"点击了%@",self.Titles[indexPath.row]);
            if (![[SharedInstance  sharedInstance] alreadyLanded]) {
//                AlertLog(nil, @"请先登录", @"确定", nil);
//                return;
            obj = [[LoginViewController alloc] init];
                
            }else{
            
            obj = [[PersonalViewController alloc] init];
            }
            break;
        case 1:
            if (![[SharedInstance  sharedInstance] alreadyLanded]) {
                //                AlertLog(nil, @"请先登录", @"确定", nil);
                //                return;
                obj = [[LoginViewController alloc] init];
                
            }else{
                
                obj = [[AddressViewController alloc] init];
            }
            break;
        case 2:
            NSLog(@"点击了%@",self.Titles[indexPath.row]);

            break;
            case 3:
            AlertLog(nil, @"确定退出当前账号吗？", @"确定", @"取消");
            
            break;
            
        default:
            break;
            
            
    }
    
//    obj.title = self.Titles[indexPath.row];
    
    [self.navigationController pushViewController:obj animated:YES];
//    [self presentViewController:obj animated:YES completion:nil];
    
}


@end
