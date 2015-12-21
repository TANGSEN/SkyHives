//
//  TCProfileController.m
//  个人中心
//
//  Created by 赵贺 on 15/12/15.
//  Copyright © 2015年 赵贺. All rights reserved.
//

#import "TCProfileController.h"
//#import "TCProfileTable.h"
#import "TopUserInfoView.h"
#import "SettingViewController.h"
#import "MyOrderController.h"
#import "MyFavoriteController.h"
#import "FeedbackController.h"
#import "ImageTitleButton.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface TCProfileController ()
/**分区图*/
@property (nonatomic,strong)NSArray *ImageArr;
/**分区title*/
@property (nonatomic,strong)NSArray *TitleArr;
/**订单图标*/
@property (nonatomic,strong)NSArray *OrderImages;
/**订单title*/
@property (nonatomic,strong)NSArray *OrderTitles;

/**资产图标*/
@property (nonatomic,strong)NSArray *TreasureDetail;
/**资产title*/
@property (nonatomic,strong)NSArray *TreasureTitles;

@property (nonatomic,strong)UILabel *TopLabel;
@property (nonatomic,strong)UILabel *BottomLabel;
@property (nonatomic,strong)TopUserInfoView *topView;
@end

@implementation TCProfileController


-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    
    [self.tableView reloadData];

}

-(void)viewDidLoad
{
    
    
    

//    self.tableView= [[UITableView alloc] initWithFrame: CGRectMake(0, 0, ApplicationframeValue.width, ApplicationframeValue.height-49)];
//    
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = FooterView;

//    [self.view addSubview:self.tableView];
}

-(NSArray *)ImageArr
{
    
    if (!_ImageArr) {
        _ImageArr = @[@"per_icon_indent",@"per_icon_indent",@"per_icon_indent",@"per_icon_treasu",@"per_icon_indent",@"profile_icon_shoucang",@"profile_icon_yijianfankui"];
    }
    return _ImageArr;
}

-(NSArray *)TitleArr
{
    
    if (!_TitleArr) {
        _TitleArr = @[@"",@"我的订单",@"",@"我的资产",@"",@"我的收藏",@"意见反馈"];
    }
    return _TitleArr;
}



-(NSArray *)OrderImages
{
    
    if (!_OrderImages) {
        _OrderImages = @[@"per_icon_daifukuan",@"per_icon_daishouhuo",@"per_icon_daipingjia",@"per_icon_daituihuo"];
    }
    return _OrderImages;
}

-(NSArray *)OrderTitles
{
    
    if (!_OrderTitles) {
        _OrderTitles = @[@"待付款",@"待收货",@"待评价",@"待退货/退款"];
    }
    return _OrderTitles;
}



-(NSArray *)TreasureTitles
{
    if (!_TreasureTitles) {
        _TreasureTitles = @[@"现金券",@"红包",@"金额",@"礼品卡"];
    }
    
    return _TreasureTitles;
}
-(NSArray *)TreasureDetail
{
    if (!_TreasureDetail) {
        _TreasureDetail = @[@"7张",@"0个",@"￥0.00",@"￥0.00"];
    }
    return _TreasureDetail;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 8;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section==1||section==3) {
        return 2;
    }else
        
        return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (indexPath.section == 0) {
        self.topView = [[TopUserInfoView  alloc] initWithFrame:CGRectMake(0, 0, ApplicationframeValue.width, TopHeight)];
        [cell.contentView addSubview:self.topView];
        
        [self.topView setUserInteractionEnabled:YES];
        [self.topView.settingButton addTarget:self action:@selector(OnClickSetting) forControlEvents:UIControlEventTouchUpInside];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR)];
        [self.topView.detailView addGestureRecognizer:tap];
        
        /**登录*/
        [self.topView.loginBtn addTarget:self action:@selector(OnClickloginBtn) forControlEvents:UIControlEventTouchUpInside];
        
        
        /**注册*/
        [self.topView.registerBtn addTarget:self action:@selector(OnClickRegisterBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    
    else  if (indexPath.section==2||indexPath.section==4||indexPath.section==7) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ApplicationframeValue.width, 15)];
        view.backgroundColor = View_BgColor;
        cell.backgroundView = view;
        [cell setUserInteractionEnabled:NO];
    }
    
    else {
        if (indexPath.row == 0) {
        
            if (indexPath.section == 1) {
                
                cell.detailTextLabel.text = @"查看全部订单";
                cell.detailTextLabel.font = AppFont(13);
                
            }

        cell.imageView.image = [[UIImage imageNamed:self.ImageArr[indexPath.section]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        cell.textLabel.text = self.TitleArr[indexPath.section];
        
            
        if (indexPath.section!=3) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        
        
    }
    }
    /**我的订单 四个小标*/
     if (indexPath.row==1&&indexPath.section == 1) {
        
        for (int i = 0; i<self.OrderImages.count; i++) {
            ImageTitleButton *button = [ImageTitleButton buttonWithType:UIButtonTypeCustom];
            
            [button setImage:[UIImage imageNamed:self.OrderImages[i]] forState:UIControlStateNormal];
            [button setTitle:self.OrderTitles[i] forState:UIControlStateNormal];
            CGFloat buttonW = self.view.frame.size.width/4;
            CGFloat buttonH = 60;
            button.frame = CGRectMake(i*buttonW, 0, buttonW, buttonH);
            button.tag = i;
            [button addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont systemFontOfSize:11];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [cell.contentView addSubview:button];
            
        }
        
    }
    /**我的资产*/
    if (indexPath.section==3&&indexPath.row == 1) {
        for (int i = 0; i<self.TreasureDetail.count; i++){
            
            UIView *view = [[UIView alloc] init];
            CGFloat buttonW = self.view.frame.size.width/4;
            CGFloat buttonH = 60;
            view.frame = CGRectMake(i*buttonW, 0, buttonW, buttonH);
            //            view.backgroundColor = RandomColor;
            CGPoint center = view.center;
            CGRect frame = view.frame;
            center.x = frame.size.width/2;
            center.y = frame.size.height/2/2+10;
            UILabel *TopLabel = [[UILabel alloc] init];
            TopLabel.width = frame.size.width;
            TopLabel.height = frame.size.height/2;
            TopLabel.center = center;
            TopLabel.textAlignment = NSTextAlignmentCenter;
            TopLabel.textColor = [UIColor blackColor];
            TopLabel.font = [UIFont systemFontOfSize:11];
            TopLabel.text = self.TreasureDetail[i];
            [view addSubview:TopLabel];
            
            UILabel *BottomLabel = [[UILabel alloc] init];
            BottomLabel.width = frame.size.width;;
            BottomLabel.height = frame.size.height/2;
            BottomLabel.centerX = frame.size.width/2;
            BottomLabel.centerY = frame.size.height/2+frame.size.height/2/2;
            BottomLabel.textColor = [UIColor blackColor];
            BottomLabel.font = [UIFont systemFontOfSize:11];
            BottomLabel.textAlignment = NSTextAlignmentCenter;
            [view addSubview:BottomLabel];
            
            BottomLabel.text = self.TreasureTitles[i];
            [cell.contentView addSubview:view];
        }
        
    }
    
   
    
    return cell;
    
    
    
}

-(void)OnClick:(UIButton *)sender{
    NSLog(@"%@",sender.titleLabel.text);
    
}

-(void)OnClickSetting{
    SettingViewController *setting = [[SettingViewController alloc] init];
    setting.title = @"设置";
    [self.navigationController pushViewController:setting animated:YES];
    
}
#warning 完善个人资料 暂未
-(void)tapGR{
    SettingViewController *setting = [[SettingViewController alloc] init];
    setting.title = @"完善";
    [self.navigationController pushViewController:setting animated:YES];
    
}

-(void)OnClickloginBtn{
    LoginViewController *login = [[LoginViewController alloc] init];
    login.title = @"登录";
    [self.navigationController pushViewController:login animated:NO];
    
    
}

-(void)OnClickRegisterBtn{
    RegisterViewController *setting = [[RegisterViewController alloc] init];
    setting.title = @"注册";
    [self.navigationController pushViewController:setting animated:NO];
    
    
}
-(void)click:(UIButton *)sender{
    NSLog(@"点击了%@",sender.titleLabel);
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return TopHeight;
    }
    else if (indexPath.section == 5||indexPath.section == 6) {
        return 45.0f;
    }else if (indexPath.section==2||indexPath.section==4||indexPath.section==7){
        
        return 15.0f;
        
    }
    else if (indexPath.row == 0) {
        return 40.0f;
    }
    else{
        
        return 60.0f;
    }
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==1&&indexPath.row==0) {
        MyOrderController *favorite = [[MyOrderController alloc] init];
        favorite.title = @"我的订单";
        [self.navigationController pushViewController:favorite animated:YES];
    }
    
    if (indexPath.section==5) {
        
        MyFavoriteController *favorite = [[MyFavoriteController alloc] init];
        favorite.title = @"我的收藏";
        [self.navigationController pushViewController:favorite animated:YES];
     
    }
    if (indexPath.section == 6) {
        FeedbackController *feedback  = [[FeedbackController alloc] init];
        [self.navigationController pushViewController:feedback animated:YES];
    }
    
    
    
}

@end
