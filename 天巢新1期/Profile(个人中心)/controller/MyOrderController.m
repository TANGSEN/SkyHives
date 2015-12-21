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
    return 20;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *identifier = @"cell";
    
#warning     如果单元格复用  猛拽 视图乱

    OrderView *view  = [[[NSBundle mainBundle]loadNibNamed:@"OrderView" owner:self options:nil]lastObject];
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
    
   


//    if (!cell) {
    
        
         cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        

        if (indexPath.row%2==0) {
            /**立即购买*/
            [view.BuyNow addTarget:self action:@selector(BuyNow:) forControlEvents:UIControlEventTouchUpInside];
            
            view.frame = cell.frame;
            view.BuyNow.tag = indexPath.row;
            [cell.contentView addSubview:view];
        }
        else
        {
        
            UIView *imageCell = [[UIView alloc] initWithFrame:CGRectZero];
            imageCell.backgroundColor = View_BgColor;
            cell.backgroundView = imageCell;
        
        }
        
       
       
        
//    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    

}

-(void)BuyNow:(UIButton *)sender
{

    NSLog(@"点击了%ld",(long)sender.tag);


}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row%2==0) {
        return 138.0f;
    }
    return 20.0f;

//    return 138.0f;
}

//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//
//    return 20;
//}



@end
