//
//  AddressViewController.m
//  天巢新1期
//
//  Created by 赵贺 on 15/12/19.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "AddressViewController.h"
#import "JPNetWork.h"
#import "NewAddressController.h"
#import "OrderAddressModel.h"
#define CHECK_ADDRESS_URL @"http://www.skyhives.com/order/getAddress"
#define CELL_HEIGHT  60
@interface AddressViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIScrollView *scrollView;
//@property (nonatomic,strong)NSMutableArray *arr;
@property(nonatomic,assign) int arr;
@property (nonatomic,strong)UILabel *bottomLabel;
@property (nonatomic,strong)UIView *footerView;
@property(nonatomic,strong)OrderAddressModel *orderAddressModel;
@property(nonatomic,strong)NSDictionary *orderDic;

@end

@implementation AddressViewController


//-(NSMutableArray *)arr
//{
//    if (!_arr) {
////        _arr = [[NSMutableArray alloc] init];
//        _arr = [OrderAddressModel demoData];
//
//    }
//    return _arr;
//
//}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.tableView reloadData];
    [self getNetwork];

    
}
- (void)viewDidLoad {
    
    [self setUpRightBarItem];
    
    [super viewDidLoad];
    
    self.view.backgroundColor = View_BgColor;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, JPScreenW, JPScreenH)];
    scrollView.scrollEnabled = YES;
    scrollView.alwaysBounceVertical = YES;
    _arr = 1;
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, JPScreenW, JPScreenH+100)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = View_BgColor;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), JPScreenW, 100)];
    [scrollView addSubview:self.tableView];
    //    [scrollView addSubview:footerView];
    
    self.tableView.tableFooterView = footerView;
    self.view.backgroundColor = View_BgColor;
    
    
    UIButton *addAdddress = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, ApplicationframeValue.width, 40)];
    [footerView addSubview:addAdddress];
    [addAdddress setTitle:@"新增地址" forState:UIControlStateNormal];
    [addAdddress setTitleColor:AppColor forState:UIControlStateNormal];
    [addAdddress setBackgroundColor: [UIColor whiteColor]];
    [addAdddress addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    addAdddress.titleLabel.font = AppFont(14);
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(addAdddress.frame), JPScreenW, 40)];
    
    self.bottomLabel = bottomLabel;
    
    if (self.arr==0) {
        bottomLabel.text = @"您还没有地址";
        
    }else
    {
        bottomLabel.text = @"您最多添加10个有效地址";
        
    }
    
    
    
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    bottomLabel.textColor = [UIColor lightGrayColor];
    bottomLabel.font = AppFont(13);
    [footerView addSubview:bottomLabel];
    footerView.backgroundColor = View_BgColor;
    scrollView.contentSize = CGSizeMake(JPScreenW, CGRectGetMaxY(self.tableView.frame));
    self.tableView.contentSize = CGSizeMake(JPScreenW, JPScreenH);
    self.scrollView = scrollView;
    self.footerView = footerView;
    [self.view addSubview:self.tableView];
    
}

-(void)getNetwork
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"zp-browse-id"] = [[SharedInstance sharedInstance]getUserID];
    
    [JPNetWork GET:CHECK_ADDRESS_URL parameters:params completionHandler:^(NSDictionary* responseObj, NSError *error) {
        
        [self showSuccessMsg:[NSString stringWithFormat:@"%@",responseObj[@"msg"]]];
        _orderDic = [[NSDictionary alloc]init];
        _orderDic = responseObj[@"data"];
        [self.tableView reloadData];
    }];
    
    
}
-(void)setUpRightBarItem{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    
    
}


-(void)addAddress{
    NewAddressController *newAddress = [[NewAddressController alloc] init];
    [self.navigationController pushViewController:newAddress animated:YES];
    
}

#pragma mark - tableview datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _arr;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    self.orderAddressModel = [OrderAddressModel mj_objectWithKeyValues:_orderDic];
    
    cell.textLabel.text = self.orderAddressModel.name;
    cell.textLabel.font = AppFont(13);
    cell.detailTextLabel.font = AppFont(12);
    cell.detailTextLabel.text = _orderAddressModel.detailed_address;
    UILabel *accessoryL = [[UILabel alloc]initWithFrame:CGRectMake(ApplicationframeValue.width/2+20, 5, 100, 30)];
    accessoryL.text = _orderAddressModel.phone;
    accessoryL.textAlignment = NSTextAlignmentCenter;
    accessoryL.font = AppFont(12);
    [cell.contentView addSubview:accessoryL];
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewAddressController *newAddressVC  = [[NewAddressController alloc] init];
    newAddressVC.orderName = _orderAddressModel.name;
    newAddressVC.orderPhone = _orderAddressModel.phone;
    newAddressVC.orderStreet = _orderAddressModel.detailed_address;
    
    [self.navigationController pushViewController:newAddressVC animated:YES];
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CELL_HEIGHT;
}
-(void)edit{
    self.navigationItem.rightBarButtonItem.title = self.tableView.editing?@"编辑":@"完成";
    [UIView animateWithDuration:0.35f animations:^{
        self.tableView.editing = !self.tableView.editing;
        
    }];
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
    
}
/**编辑样式*/
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete;
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //        [_arr removeObjectAtIndex:indexPath.row];
        _arr--;
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
        });
    }
    if (self.arr==0) {
        _bottomLabel.text = @"您还没有地址";
        
    }else
    {
        _bottomLabel.text = @"您最多添加10个有效地址";
        
        
    }
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
@end
