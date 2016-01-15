//
//  MyFavoriteController.m
//  天巢新1期
//
//  Created by 赵贺 on 15/12/16.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "MyFavoriteController.h"
#import "TCOrderCell.h"
#import "FurnitureModel.h"

#define CELLH 110


@interface MyFavoriteController ()

@property (nonatomic ,strong) NSMutableArray *furnitures;

@property (nonatomic ,weak) UITableView *tableView;

@end

@implementation MyFavoriteController 


-(void)viewDidLoad
{
    [super viewDidLoad];
    
#warning 查询我的收藏失败,服务器返回status code 404
//    [JPNetWork GET:@"http://192.168.1.156:8080/zp/userbehaviorapi/collection" parameters:@{@"zp-browse-id":kZPBROWSEID} completionHandler:^(id responseObj, NSError *error) {
//        NSLog(@"查询我的收藏responseObj===%@",responseObj);
//        NSLog(@"查询我的收藏error===%@",error);
//        
//        [FurnitureModel mj_objectWithKeyValues:responseObj];
//        
//        if ([responseObj[@"status"] isEqualToNumber:@1]) {
//            [self showSuccessMsg:responseObj[@"msg"]];
//        }else{
//            [self showSuccessMsg:@"查询失败"];
//        }
//    }];
    
    [self checkMyFavorites];
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, ApplicationframeValue.width, 45)];
    [self.view addSubview:titleLabel];
    titleLabel.text = @"收藏商品";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.textColor = AppColor;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, titleLabel.origin.y+titleLabel.size.height, ApplicationframeValue.width, ApplicationframeValue.height-titleLabel.size.height-64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ApplicationframeValue.width, 0)];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}


- (void)checkMyFavorites{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"zp-browse-id"] = kZPBROWSEID;
    
    [JPNetWork GET:@"http://www.skyhives.com/userbehaviorapi/collection" parameters:parmas completionHandler:^(NSDictionary *responseObj, NSError *error) {
        NSLog(@"查询我的收藏responseObj===%@",responseObj);
        NSLog(@"查询我的收藏error===%@",error);
        
        
        NSMutableArray *furnitures = [FurnitureModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        NSLog(@"%@",furnitures);
        
        self.furnitures = furnitures;
        if ([responseObj[@"status"] isEqualToNumber:@0]) {
            [self showSuccessMsg:responseObj[@"msg"]];
        }
        
        [self.tableView.mj_header endRefreshing];
        
        self.tableView.contentSize = CGSizeMake(0, CELLH * furnitures.count);
        
        [self.tableView reloadData];
        
    }];
}


#pragma mark - tableViewDelegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.furnitures.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FurnitureModel *furniture = self.furnitures[indexPath.row];
    static NSString *identifier = @"TCOrderCell";
    TCOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell  = [[[NSBundle mainBundle]loadNibNamed:@"TCOrderCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.priceLabel.text = [NSString stringWithFormat:@"%ld",furniture.price];
    cell.productNameLabel.text = furniture.name;
    cell.soldCount.text = [NSString stringWithFormat:@"%ld",furniture.sold_count];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:furniture.thumb]];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 110.0f;
}
@end
