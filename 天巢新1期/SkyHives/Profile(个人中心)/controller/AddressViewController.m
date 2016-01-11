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
#define CHECK_ADDRESS_URL @"http://www.skyhives.com/order/getAddress"
#define CELL_HEIGHT  60
@interface AddressViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (assign, nonatomic) int CellCount;
@end

@implementation AddressViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [JPNetWork GET:CHECK_ADDRESS_URL parameters:nil completionHandler:^(id responseObj, NSError *error) {
        
        /**获取到收货地址
         根据个数然后
         
         */
        _CellCount = 1;
        NSLog(@"CHECK_ADDRESS_responseObj====%@",responseObj);
    }];
    
}
- (void)viewDidLoad {
    
    [self setUpRightBarItem];
    
    [super viewDidLoad];
    self.view.backgroundColor = View_BgColor;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, JPScreenW, JPScreenH)];
    scrollView.scrollEnabled = YES;
    scrollView.alwaysBounceVertical = YES;
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, JPScreenW, 60)];
    self.tableView.backgroundColor = AppColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), JPScreenW, 100)];
    [scrollView addSubview:self.tableView];
    [scrollView addSubview:footerView];
    
    self.view.backgroundColor = View_BgColor;
    
    
    UIButton *addAdddress = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, ApplicationframeValue.width, 40)];
    [footerView addSubview:addAdddress];
    [addAdddress setTitle:@"新增地址" forState:UIControlStateNormal];
    [addAdddress setTitleColor:AppColor forState:UIControlStateNormal];
    [addAdddress setBackgroundColor: [UIColor whiteColor]];
    [addAdddress addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    addAdddress.titleLabel.font = AppFont(14);
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(addAdddress.frame), JPScreenW, 40)];
    if (_CellCount==0) {
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
    scrollView.contentSize = CGSizeMake(JPScreenW, CGRectGetMaxY(footerView.frame));
    [self.view addSubview:scrollView];
    
}

-(void)setUpRightBarItem{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    
    
}

-(void)edit{
    
    
}
-(void)addAddress{
    NewAddressController *newAddress = [[NewAddressController alloc] init];
    [self.navigationController pushViewController:newAddress animated:YES];
    
}

#pragma mark - tableview datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",_CellCount);
    //    return _CellCount;
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CELL_HEIGHT;
}

@end
