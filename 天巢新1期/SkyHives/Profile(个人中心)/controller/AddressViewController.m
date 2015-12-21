//
//  AddressViewController.m
//  天巢新1期
//
//  Created by 赵贺 on 15/12/19.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "AddressViewController.h"

@interface AddressViewController ()

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = View_BgColor;
    UITableViewCell *cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.textLabel.text = [[SharedInstance sharedInstance] getUserName];
    cell.detailTextLabel.text = @"广东省广州市";
    UILabel *accessoryL = [[UILabel alloc]initWithFrame:CGRectMake(ApplicationframeValue.width/2+20, 0, 80, 30)];
    accessoryL.text = [[SharedInstance sharedInstance] getPhoneNumber];
    accessoryL.font = AppFont(11);
//    cell.accessoryView = accessoryL;
    [cell.contentView addSubview:accessoryL];
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    
    cell.frame = CGRectMake(0, 20+64, ApplicationframeValue.width, 60);
    
    [self.view addSubview:cell];
    
    UIButton *addAdddress = [[UIButton alloc] initWithFrame:CGRectMake(0, ApplicationframeValue.height-40, ApplicationframeValue.width, 40)];
    [self.view addSubview:addAdddress];
    [addAdddress setTitle:@"新增地址" forState:UIControlStateNormal];
    [addAdddress setTitleColor:AppColor forState:UIControlStateNormal];
    [addAdddress setBackgroundColor: [UIColor whiteColor]];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
