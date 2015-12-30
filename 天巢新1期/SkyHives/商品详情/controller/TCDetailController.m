//
//  TCDetailTableController.m
//  天巢网
//
//  Created by tangjp on 15/11/17.
//  Copyright © 2015年 tangjp. All rights reserved.
//  商品详情

#import "TCDetailController.h"
#import "DetailViewController.h"
#import "AttributeView.h"

#import "GGCSView.h"
#import "TWXQView.h"


@interface TCDetailController () <CustomerDelegate ,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) CustomerView *topView;
/** 图文详情视图 */
@property (nonatomic ,strong) TWXQView *twxqView;
/** 规格参数视图 */
@property (nonatomic ,strong) GGCSView *ggcsView;
/** 滚动图加标题的视图 */
@property (nonatomic ,strong) DetailViewController *detailView;

@property (nonatomic ,strong) NSIndexPath *indexpath;

@property (nonatomic ,weak) UITableViewCell *cell;

@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic ,strong) NSArray *texts;

@property (nonatomic ,weak) UIButton *backBtn;

@property (nonatomic ,strong) UIScrollView *attributeScrollView;

@property (nonatomic ,strong) UIView *attributeView;
@end

@implementation TCDetailController

- (TWXQView *)twxqView{
    if (!_twxqView){
        _twxqView = [TWXQView view];
        _twxqView.frame = CGRectMake(0, 0, JPScreenW, [TWXQView height]);
    }
    return _twxqView;
}

- (DetailViewController *)detailView{
    if (!_detailView){
        _detailView = [[DetailViewController alloc]init];
    }
    return _detailView;
}

- (GGCSView *)ggcsView{
    if (!_ggcsView) {
        _ggcsView = [[GGCSView alloc]initWithFrame:CGRectMake(0, 0, JPScreenW, [GGCSView Height]) style:UITableViewStylePlain];
        _ggcsView.hidden = YES;
    }return _ggcsView;
}

- (CustomerView *)topView{
    if (!_topView){
        _topView = [[CustomerView alloc] initWithFrame:CGRectMake(0, 0, JPScreenW, 47) initButWithArray:[NSArray arrayWithObjects:@"商品详情",@"规格参数",nil] butFont:(NSInteger)14];
        _topView.delegate = self;
        _topView.clipsToBounds = YES;
    }
    
    return _topView;
}

- (UIScrollView *)attributeScrollView{
    if (!_attributeScrollView) {
        _attributeScrollView = [[UIScrollView alloc]init];
        _attributeScrollView.showsHorizontalScrollIndicator = NO;
        _attributeScrollView.showsVerticalScrollIndicator = NO;
    }
    return _attributeScrollView;
}

- (UITableView *)tableView{
    if (!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, JPScreenW, self.view.height-50) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.userInteractionEnabled = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = NO;
    }
    return _tableView;
}

- (NSArray *)texts{
    if (!_texts){
        _texts = [[NSArray alloc]initWithObjects:@"右三人+2腰枕[带储物柜]",@"扶手单人+1腰枕",@"顶级黄牛真皮脚踏",@"左贵妃",@"无扶手单人+1腰枕",@"右贵妃+1腰枕",@"右三人+2腰枕[带储物柜]",@"扶手单人+1腰枕",@"顶级黄牛真皮脚踏",@"左贵妃",@"无扶手单人+1腰枕",@"右贵妃+1腰枕",@"sdddfsfsdfasfsedgfgsd", nil];
    }
    return _texts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = @"商品详情";
    [self setupPhoneBtnAndGouWuBtn];
    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];

}


- (void)setupPhoneBtnAndGouWuBtn{
    UIButton *phoneBtn = [[UIButton alloc]init];
    phoneBtn.x = 0;
    phoneBtn.height = 50;
    phoneBtn.width = JPScreenW / 2;
    phoneBtn.y = self.view.height - 50;
    [phoneBtn setTitle:@"电话" forState:UIControlStateNormal];
    [phoneBtn setImage:[UIImage imageNamed:@"图层-234"] forState:UIControlStateNormal];
    [phoneBtn addTarget:self action:@selector(getmodel) forControlEvents:UIControlEventTouchUpInside];
    phoneBtn.backgroundColor = [UIColor blackColor];
    
    UIButton *gouBtn = [[UIButton alloc]init];
    gouBtn.backgroundColor = [UIColor grayColor];
    [gouBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [gouBtn addTarget:self action:@selector(gouwu) forControlEvents:UIControlEventTouchUpInside];
    [gouBtn setImage:[UIImage imageNamed:@"icon_gouwu"] forState:UIControlStateNormal];
    gouBtn.frame = phoneBtn.frame;
    gouBtn.x = JPScreenW / 2;
    [self.view addSubview:gouBtn];
    [self.view addSubview:phoneBtn];
}

/**
 *  加入购物车按钮响应方法
 */
- (void)gouwu{
}
/**
 *  测试功能
 */
- (void)getmodel{
}

#pragma mark - CustomerDelegate
-(void)OnclickCustomerTag:(NSInteger)customerTag
{
    if (customerTag == self.topView.currentIndex) {
        return;
    }
    
    NSLog(@"%ld",(long)customerTag);
    
    switch (customerTag) {
        case 1:
            self.twxqView.hidden = NO;
            self.ggcsView.hidden = YES;
            [self.tableView reloadRowsAtIndexPaths:@[self.indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
            NSLog(@"商品详情");
            break;
        case 2:
            self.twxqView.hidden = YES;
            self.ggcsView.hidden = NO;
            [self.tableView reloadRowsAtIndexPaths:@[self.indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
            NSLog(@"规格参数");
        default:
            break;
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *Identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identifier];
    }
    for (UIView *subView in cell.contentView.subviews)
    {
        [subView removeFromSuperview];
    }
    cell.textLabel.text = nil;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.userInteractionEnabled = YES;
    if (indexPath.section == 0) {
        self.detailView.view.frame = CGRectMake(0, 0, JPScreenW, [DetailViewController height]);
        [cell.contentView addSubview:self.detailView.view];
        cell.contentView.userInteractionEnabled = YES;
    }else if (indexPath.section == 2){
        [cell.contentView addSubview:self.topView];
    }else if (indexPath.section == 3){
        self.indexpath = indexPath;
        [cell.contentView addSubview:self.twxqView];
        [cell.contentView addSubview:self.ggcsView];
    }else {
        cell.textLabel.text = @"类型\\规格\\颜色";
        cell.textLabel.textColor = [UIColor grayColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)backBtnClick{
    [UIView animateWithDuration:0.25 animations:^{
        self.attributeView.y = self.view.height;
    }completion:^(BOOL finished) {
        [self.attributeView removeFromSuperview];
    }];
    
}

- (void)setupAttributeScrollView{
    
    UIView *attributeView = [[UIView alloc]init];
    attributeView.backgroundColor = [UIColor grayColor];
    // header
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, JPScreenW, 100)];
    // 商品图片
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.x = 10;
    imageView.y = 10;
    imageView.height = headerView.height - 20;
    imageView.width = imageView.height;
    imageView.image = [UIImage imageNamed:@"ertong"];
    
    // 商品价格
    UILabel * priceLabel = [[UILabel alloc]init];
    priceLabel.text = @"￥2988";
    priceLabel.font = [UIFont boldSystemFontOfSize:15];
    priceLabel.textColor = [UIColor redColor];
    CGSize priceSize = [priceLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:15]];
    priceLabel.frame = (CGRect){{CGRectGetMaxX(imageView.frame) + 10, 30},priceSize};
    
    // 销量
    UILabel *countLabel = [[UILabel alloc]init];
    countLabel.text = @"已售1000";
    countLabel.font = [UIFont boldSystemFontOfSize:15];
    CGSize countSize = [countLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:15]];
    countLabel.frame = (CGRect){{CGRectGetMaxX(imageView.frame) + 10, CGRectGetMaxY(priceLabel.frame) + 10},countSize};
    
    
    // 推出按钮
    UIButton *backBtn = [[UIButton alloc]init];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.width = 40;
    backBtn.height = 40;
    backBtn.x = headerView.width - backBtn.width;
    backBtn.y = priceLabel.y - 10;
    [backBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backBtn];
    self.backBtn = backBtn;
    
    [headerView addSubview:imageView];
    [headerView addSubview:priceLabel];
    [headerView addSubview:countLabel];
    [attributeView addSubview:headerView];
    
    self.attributeScrollView.x = 0;
    self.attributeScrollView.width = JPScreenW;
    self.attributeScrollView.height = 300;
    self.attributeScrollView.y = CGRectGetMaxY(headerView.frame);
    
    UIView *view1 = [AttributeView attributeViewWithTitle:@"类型" titleFont:[UIFont boldSystemFontOfSize:20] attributeTexts:self.texts];
    view1.y = 0;
    UIView *view2 = [AttributeView attributeViewWithTitle:@"颜色" titleFont:[UIFont boldSystemFontOfSize:20] attributeTexts:@[@"yellow",@"blue",@"red"]];
    view2.y = CGRectGetMaxY(view1.frame)+1;
    UIView *view3 = [AttributeView attributeViewWithTitle:@"规格" titleFont:[UIFont boldSystemFontOfSize:20] attributeTexts:@[@"1500mm*2000mm",@"1500mm*2200mm"]];
    view3.y = CGRectGetMaxY(view2.frame)+1;

    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame), JPScreenW, 1)];
    lineLabel.backgroundColor = [UIColor grayColor];
    [self.attributeScrollView addSubview:lineLabel];
    
    UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view2.frame), JPScreenW, 1)];
    lineLabel2.backgroundColor = [UIColor grayColor];
    [self.attributeScrollView addSubview:lineLabel2];
    
    self.attributeScrollView.contentSize = CGSizeMake(JPScreenW, CGRectGetMaxY(view3.frame));
    [self.attributeScrollView addSubview:view1];
    [self.attributeScrollView addSubview:view2];
    [self.attributeScrollView addSubview:view3];
    
    
    
    
    attributeView.x = 0;
    attributeView.width = JPScreenW;
    attributeView.height = 500;
    attributeView.y = self.view.height;
    attributeView.backgroundColor = [UIColor whiteColor];
    
    // 添加加入购物车按钮
    UIButton *GWBtn = [[UIButton alloc]init];
    GWBtn.height = 40;
    GWBtn.width = JPScreenW;
    GWBtn.x = 0;
    GWBtn.y = attributeView.height - GWBtn.height;
    [GWBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [GWBtn setTitleColor:Color(0, 0, 0) forState:UIControlStateNormal];
    [GWBtn addTarget:self action:@selector(gouwu) forControlEvents:UIControlEventTouchUpInside];
    GWBtn.backgroundColor = Color(250, 86, 87);
    [attributeView addSubview:GWBtn];
    
    [attributeView addSubview:self.attributeScrollView];
    [self.view addSubview:attributeView];
    
    [UIView animateWithDuration:0.25 animations:^{
        attributeView.y = self.view.height - attributeView.height;
    }completion:^(BOOL finished) {
        
    }];
    
    self.attributeView = attributeView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        [self setupAttributeScrollView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [DetailViewController height];
    }
    if (indexPath.section == 2) {
        return 47;
    }
    if (indexPath.section == 3) {
        if (self.ggcsView.hidden == YES) {
            return [TWXQView height];
        }else{
            return [GGCSView Height];
        }
    }
    
    return 44;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    if (section == 3) {
        return 0;
    }
    return 20;
}




@end
