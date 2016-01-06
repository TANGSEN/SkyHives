//
//  MyFavoriteController.m
//  天巢新1期
//
//  Created by 赵贺 on 15/12/16.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "MyFavoriteController.h"
#import "TCOrderCell.h"
@implementation MyFavoriteController

-(void)viewDidLoad
{
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

}

#pragma mark - tableViewDelegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"TCOrderCell";
    TCOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell  = [[[NSBundle mainBundle]loadNibNamed:@"TCOrderCell" owner:self options:nil]lastObject];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

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
