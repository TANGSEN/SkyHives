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

@interface MyOrderController ()<CustomerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSArray *Titles;
@end


@implementation MyOrderController
-(NSArray *)Titles
{
    if (!_Titles) {
        _Titles = @[@"全部",@"代付款",@"待收货",@"待评价",@"交易完成"] ;
    }
    return _Titles;

}
-(void)viewDidLoad
{
    self.title = @"我的订单";
    
    
    CustomerView *topView = [[CustomerView alloc] initWithFrame:CGRectMake(0, 64, ApplicationframeValue.width, 47) initButWithArray:self.Titles butFont:15];
    topView.delegate = self;
    [self.view addSubview:topView];
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame)+10, ApplicationframeValue.width, ApplicationframeValue.height-47-64)];
    
    tableView.delegate = self;
    tableView.dataSource = self;
//    tableView.tableFooterView = FooterView;
//    tableView.tableFooterView.backgroundColor = View_BgColor;
    tableView.backgroundColor = View_BgColor;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.bounces = NO;
    [self.view addSubview:tableView];
    
    


}
-(void)OnclickCustomerTag:(NSInteger)customerTag
{

    switch (customerTag) {
        case 1:
            NSLog(@"点击了%@",self.Titles[customerTag-1]);
            break;
        case 2:
            NSLog(@"点击了%@",self.Titles[customerTag-1]);
            
            break;
        case 3:
            NSLog(@"点击了%@",self.Titles[customerTag-1]);
            
            break;
        case 4:
            NSLog(@"点击了%@",self.Titles[customerTag-1]);
            break;
        case 5:
            NSLog(@"点击了%@",self.Titles[customerTag-1]);
            break;
   
    }


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
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    /**立即购买*/
    [cell.BuyNow addTarget:self action:@selector(BuyNow:) forControlEvents:UIControlEventTouchUpInside];
    cell.BuyNow.tag = indexPath.row;
    
    return cell;
}

-(void)BuyNow:(UIButton *)sender
{

    NSLog(@"点击了%ld",(long)sender.tag);


}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 148.0f;
}





@end
