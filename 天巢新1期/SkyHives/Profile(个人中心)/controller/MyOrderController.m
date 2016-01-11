//
//  MyOrderController.m
//  天巢新1期
//
//  Created by 赵贺 on 15/12/16.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "MyOrderController.h"
#import "CustomerView.h"
#import "OrderView.h"
#import "HomeNetWork.h"
#import "FurnituresNetWork.h"

@interface MyOrderController ()<CustomerDelegate,UITableViewDataSource,UITableViewDelegate, MBProgressHUDDelegate>
@property (nonatomic,strong)NSArray *Titles;
@property (nonatomic ,weak) OrderView *cell;
@property (nonatomic ,weak) UITableView *tableView;
@property (nonatomic ,copy) NSString *btnType;
@property (nonatomic ,assign) FurnitureType type;
@property (nonatomic ,strong) MBProgressHUD *hud;

@end


@implementation MyOrderController

- (MBProgressHUD *)hud{
    if (!_hud){
        _hud = [[MBProgressHUD alloc]init];
        _hud.delegate = self;
    }
    return _hud;
}

-(NSArray *)Titles
{
    if (!_Titles) {
        _Titles = @[@"代付款",@"待收货",@"待评价",@"待退货"] ;
    }
    return _Titles;

}
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    self.title = @"我的订单";
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    CustomerView *topView = [[CustomerView alloc] initWithFrame:CGRectMake(0, 64, ApplicationframeValue.width, 47) initButWithArray:self.Titles butFont:15 selectedIndex:self.selectedIndex];
    
    
    topView.delegate = self;
    
    [self OnclickCustomerTag:self.selectedIndex];
    
    [self.view addSubview:topView];
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame)+10, ApplicationframeValue.width, ApplicationframeValue.height-47-64)];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = View_BgColor;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.bounces = YES;
    [self.view addSubview:tableView];
    
    self.tableView = tableView;


}

-(void)OnclickCustomerTag:(NSInteger)customerTag
{

    switch (customerTag) {
        case 0:
            NSLog(@"点击了%@",self.Titles[customerTag]);
            self.type = FurnitureTypeSofa;
            self.btnType = @"立即支付";
            break;
        case 1:
            NSLog(@"点击了%@",self.Titles[customerTag]);
            self.type = FurnitureTypeFoodie;
            self.btnType = @"确认收货";
            break;
        case 2:
            NSLog(@"点击了%@",self.Titles[customerTag]);
            self.type = FurnitureTypeChildren;
            self.btnType = @"立即评价";
            break;
        case 3:
            NSLog(@"点击了%@",self.Titles[customerTag]);
            self.type = FurnitureTypeBed;
            self.btnType = @"确认退货";
            break;
            
        default:break;
    }

    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *identifier = @"cell";
    OrderView *cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"OrderView" owner:self options:nil]lastObject];
    }
    
    for (UIView *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    cell.userInteractionEnabled = YES;
//    [FurnituresNetWork getFurnituresWithFurnitureType:self.type block:^(NSArray *model, NSError *error) {
//        [model enumerateObjectsUsingBlock:^(FurnitureModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSLog(@"%@",obj.name);
//        }];
//    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    /**立即购买*/
    [cell.BuyNow addTarget:self action:@selector(BuyNow:) forControlEvents:UIControlEventTouchUpInside];
    [cell.BuyNow setTitle:self.btnType forState:UIControlStateNormal];
    cell.BuyNow.tag = indexPath.row;
    self.cell = cell;
    return cell;
    
    

}

-(void)BuyNow:(UIButton *)sender
{
    if ([self.btnType isEqualToString:@"立即支付"]) {
        NSLog(@"点击了立即支付%ld",(long)sender.tag);
    }else if ([self.btnType isEqualToString:@"确认收货"]){
        NSLog(@"点击了确认收货%ld",(long)sender.tag);
    }else if ([self.btnType isEqualToString:@"立即评价"]){
        NSLog(@"点击了立即评价%ld",(long)sender.tag);
    }else if ([self.btnType isEqualToString:@"确认退货"]){
        NSLog(@"点击了确认退货%ld",(long)sender.tag);
    }
}

- (void)tapHud:(MBProgressHUD *)hud{
    NSLog(@"执行了tapHud");
    [self.hud hide:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.hud showSuccessMsg:[NSString stringWithFormat:@"点击了%ld行",indexPath.row]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 148.0f;
}



@end
