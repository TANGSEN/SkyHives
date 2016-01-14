//
//  TCDetailTableController.m
//  天巢网
//
//  Created by tangjp on 15/11/17.
//  Copyright © 2015年 tangjp. All rights reserved.
//  商品详情

#import "TCDetailController.h"
#import "DetailView.h"
#import "AttributeView.h"
#import "GGCSView.h"
#import "TWXQView.h"
#import "Furniture.h"
#import "FurnitureNetWork.h"


@interface TCDetailController () <CustomerDelegate ,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) CustomerView *topView;
/** 图文详情视图 */
@property (nonatomic ,strong) TWXQView *twxqView;
/** 规格参数视图 */
@property (nonatomic ,strong) GGCSView *ggcsView;
/** 滚动图加标题的视图 */
@property (nonatomic ,strong) DetailView *detailView;

@property (nonatomic ,strong) NSIndexPath *indexpath;

@property (nonatomic ,weak) UITableViewCell *cell;

@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic ,strong) NSArray *texts;

@property (nonatomic ,weak) UIButton *backBtn;

@property (nonatomic ,strong) UIScrollView *attributeScrollView;

@property (nonatomic ,strong) UIView *attributeView;

@property (nonatomic ,strong) Furniture *furnture;

@property (nonatomic,strong)UIControl *overlay;
@end

@implementation TCDetailController

- (TWXQView *)twxqView{
    if (!_twxqView){
        _twxqView = [TWXQView view];
        _twxqView.frame = CGRectMake(0, 0, JPScreenW, [TWXQView height]);
    }
    return _twxqView;
}



- (CustomerView *)topView{
    if (!_topView){
        _topView = [[CustomerView alloc] initWithFrame:CGRectMake(0, 0, JPScreenW, 47) initButWithArray:[NSArray arrayWithObjects:@"商品详情",@"规格参数",nil] butFont:(NSInteger)14 selectedIndex:0];
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

- (UIControl *)overlay{
    if (!_overlay){
        _overlay = [[UIControl alloc]initWithFrame:self.view.bounds];
        _overlay.alpha = 0.7;
        _overlay.backgroundColor = [UIColor grayColor];
        _overlay.y = self.view.height;
    }
    return _overlay;
}

- (NSArray *)texts{
    if (!_texts){
        _texts = [[NSArray alloc]initWithObjects:@"右三人+2腰枕[带储物柜]",@"扶手单人+1腰枕",@"顶级黄牛真皮脚踏",@"左贵妃",@"无扶手单人+1腰枕", nil];
    }
    return _texts;
}

- (void)setFurniture:(FurnitureModel *)furniture{
    _furniture = furniture;
   [FurnitureNetWork getFurnituresWithFurnitureId:furniture.id block:^(Furniture *model, NSError *error) {
       self.furnture = model;
       // 商品详情视图
       self.detailView = [[DetailView alloc]initWithImages:@[self.furniture.thumb] furniture:model];
       
       // 规格参数视图
       self.ggcsView = [[GGCSView alloc]initWithFrame:CGRectMake(0, 0, JPScreenW, [GGCSView Height]) style:UITableViewStylePlain];
       self.ggcsView.hidden = YES;
       self.ggcsView.furniture = model;
       
       // 刷新table
       [self.tableView reloadData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_shoucang"] style:0 target:self action:@selector(rightBarButtonClick)];
    [self.view addSubview:self.tableView];
    self.title = @"商品详情";
    [self setupPhoneBtnAndGouWuBtn];
    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
}

/**
 *  右侧按钮点击方法
 */
#warning 添加收藏未完成,查看以收藏商品失败,服务器返回数据为null
- (void)rightBarButtonClick{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"zp-browse-id"] = kZPBROWSEID;
    params[@"status"] = @1;
    params[@"g_id"] = @(self.furniture.id);
    params[@"is_item"] = @1;
    [JPNetWork GET:@"http://www.skyhives.com/goods/addcollection" parameters:params completionHandler:^(NSDictionary *responseObj, NSError *error) {
        NSLog(@"添加%@",responseObj);
        NSLog(@"msg===%@",responseObj[@"msg"]);
        if ([responseObj[@"status"] isEqualToNumber:@1]) {
            [self showSuccessMsg:responseObj[@"msg"]];
        }else{
            [self showSuccessMsg:responseObj[@"msg"]];
        }
    }];
}

- (void)setupPhoneBtnAndGouWuBtn{
    /** 打电话给商家 */
    UIButton *phoneBtn = [[UIButton alloc]init];
    phoneBtn.x = 0;
    phoneBtn.height = 50;
    phoneBtn.width = JPScreenW / 3;
    phoneBtn.y = self.view.height - 50;
    [phoneBtn setTitle:@"电话" forState:UIControlStateNormal];
    [phoneBtn setImage:[UIImage imageNamed:@"图层-234"] forState:UIControlStateNormal];
    [phoneBtn bk_addEventHandler:^(id sender) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008066939"]];
    } forControlEvents:UIControlEventTouchUpInside];
    phoneBtn.backgroundColor = [UIColor blackColor];
    
    /** 实景体验 */
    UIButton *ARBtn = [[UIButton alloc]init];
    ARBtn.x = CGRectGetMaxX(phoneBtn.frame);
    ARBtn.height = 50;
    ARBtn.width = JPScreenW / 3;
    ARBtn.y = self.view.height - 50;
    [ARBtn setTitle:@"实景体验" forState:UIControlStateNormal];
    [ARBtn setImage:[UIImage imageNamed:@"图层-234"] forState:UIControlStateNormal];
    [ARBtn setBackgroundColor:Color(178, 90, 53)];
    [ARBtn bk_addEventHandler:^(id sender) {

        NSLog(@"推出实景体验控制器");
    } forControlEvents:UIControlEventTouchUpInside];
    
    /** 加入购物车 */
    UIButton *gouBtn = [[UIButton alloc]init];
    gouBtn.backgroundColor = [UIColor grayColor];
    [gouBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [gouBtn bk_addEventHandler:^(id sender) {
        
        [self addFurnitureObjectToShoppingCar];

        
    } forControlEvents:UIControlEventTouchUpInside];
    [gouBtn setImage:[UIImage imageNamed:@"icon_gouwu"] forState:UIControlStateNormal];
    gouBtn.frame = ARBtn.frame;
    gouBtn.width = JPScreenW / 3;
    gouBtn.x = CGRectGetMaxX(ARBtn.frame);
    [self.view addSubview:gouBtn];
    [self.view addSubview:phoneBtn];
    [self.view addSubview:ARBtn];
}

#warning 添加到购物车失败,显示库存不足!
- (void)addFurnitureObjectToShoppingCar{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"count"] = @1;
    parmas[@"g_id"] = @(self.furniture.id);
    NSLog(@"self.furniture.id==%ld",(long)self.furniture.id);
    parmas[@"i_id"] = @(self.furnture.i_id);
    NSLog(@"self.furnture.i_id===%ld",(long)self.furnture.i_id);
    parmas[@"sid"] = @1;
    parmas[@"is_item"] = @1;
    parmas[@"zp-browse-id"] = kZPBROWSEID;
    
    [JPNetWork POST:@"http://www.skyhives.com/m/add?" parameters:parmas completionHandler:^(NSDictionary *responseObj, NSError *error) {
        
//        if (error == nil && [responseObj[@"status"] isEqualToNumber:@1]) {
//            [self showSuccessMsg:@"亲~~ 已成功加入购物车"];
//        }
        
        if ([responseObj[@"status"] isEqualToNumber:@1]) {
            [self showSuccessMsg:responseObj[@"msg"]];
        }else{
            [self showSuccessMsg:responseObj[@"msg"]];
        }
        
        NSLog(@"msg --- %@",responseObj[@"msg"]);
        NSLog(@"添加到购物车responseObj%@",responseObj);
        NSLog(@"添加到购物车error%@",error);
    }];
}

/**
 *  加入购物车按钮响应方法
 */
- (void)gouwu{
    
    [self addFurnitureObjectToShoppingCar];
    
}
/**
 *  测试功能
 */
- (void)getmodel{
}

#pragma mark - CustomerDelegate
-(void)OnclickCustomerTag:(NSInteger)customerTag
{
    
    NSLog(@"%ld",(long)customerTag);
    
    switch (customerTag) {
        case 0:
            self.twxqView.hidden = NO;
            self.ggcsView.hidden = YES;
            [self.tableView reloadRowsAtIndexPaths:@[self.indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
            NSLog(@"商品详情");
            break;
        case 1:
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
        self.detailView.frame = CGRectMake(0, 0, JPScreenW, [DetailView height]);
        [cell.contentView addSubview:self.detailView];
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
        self.overlay.y = self.view.height;
        self.attributeView.y = self.view.height;
    }completion:^(BOOL finished) {
        [self.overlay removeFromSuperview];
        [self.attributeView removeFromSuperview];
    }];
    
}

- (UIView *)attributeView{
    if (!_attributeView){
        _attributeView = [[UIView alloc]init];
        _attributeView.backgroundColor = [UIColor grayColor];
        // header
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, JPScreenW, 150)];
        // 商品图片
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.x = 10;
        imageView.y = -20;
        imageView.height = headerView.height - 20;
        imageView.width = imageView.height + 30;
        imageView.layer.borderWidth = 0.5;
        imageView.layer.borderColor = Color(250, 86, 87).CGColor;
        imageView.layer.cornerRadius = 10.0f;
        imageView.clipsToBounds = YES;
        imageView.backgroundColor = [UIColor whiteColor];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.furniture.thumb] placeholderImage:[UIImage imageNamed:@"placehyolder"]];
        
        // 商品价格
        UILabel * priceLabel = [[UILabel alloc]init];
        priceLabel.text = [NSString stringWithFormat:@"￥%ld",self.furniture.price];
        priceLabel.font = [UIFont boldSystemFontOfSize:15];
        priceLabel.textColor = [UIColor redColor];
        CGSize priceSize = [priceLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:15]];
        priceLabel.frame = (CGRect){{CGRectGetMaxX(imageView.frame) + 10, 25},priceSize};
        
        // 销量
        UILabel *countLabel = [[UILabel alloc]init];
        countLabel.text = @"已售999";
        countLabel.font = [UIFont boldSystemFontOfSize:15];
        CGSize countSize = [countLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:15]];
        countLabel.frame = (CGRect){{CGRectGetMaxX(imageView.frame) + 10, CGRectGetMaxY(priceLabel.frame) + 15},countSize};
        
        
        // 退出按钮
        UIButton *backBtn = [[UIButton alloc]init];
        [backBtn setImage:[UIImage imageNamed:@"icon_shibai"] forState:UIControlStateNormal];
        backBtn.width = 30;
        backBtn.height = 30;
        backBtn.x = headerView.width - backBtn.width-10;
        backBtn.y = priceLabel.y - 10;
        [backBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        backBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:backBtn];
        self.backBtn = backBtn;
        
        [headerView addSubview:imageView];
        [headerView addSubview:priceLabel];
        [headerView addSubview:countLabel];
        [_attributeView addSubview:headerView];
        
        self.attributeScrollView.x = 0;
        self.attributeScrollView.width = JPScreenW;
        self.attributeScrollView.height = 300;
        self.attributeScrollView.y = CGRectGetMaxY(headerView.frame) - 40;
        
        UIView *view1 = [AttributeView attributeViewWithTitle:@"类型" titleFont:[UIFont boldSystemFontOfSize:20] attributeTexts:self.texts];
        view1.y = 0;
        UIView *view2 = [AttributeView attributeViewWithTitle:@"颜色" titleFont:[UIFont boldSystemFontOfSize:20] attributeTexts:@[@"yellow",@"blue",@"red"]];
        view2.y = CGRectGetMaxY(view1.frame)+1;
        UIView *view3 = [AttributeView attributeViewWithTitle:@"规格" titleFont:[UIFont boldSystemFontOfSize:20] attributeTexts:@[@"1500mm*2000mm",@"1500mm*2200mm"]];
        view3.y = CGRectGetMaxY(view2.frame)+1;
        
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame), JPScreenW, 1)];
        lineLabel.backgroundColor = [UIColor grayColor];
        lineLabel.alpha = 0.5;
        [self.attributeScrollView addSubview:lineLabel];
        
        UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view2.frame), JPScreenW, 1)];
        lineLabel2.backgroundColor = [UIColor grayColor];
        lineLabel.alpha = 0.5;
        [self.attributeScrollView addSubview:lineLabel2];
        
        self.attributeScrollView.contentSize = CGSizeMake(JPScreenW, CGRectGetMaxY(view3.frame) + 10);
        [self.attributeScrollView addSubview:view1];
        [self.attributeScrollView addSubview:view2];
        [self.attributeScrollView addSubview:view3];
        
        
        _attributeView.x = 0;
        _attributeView.width = JPScreenW;
        _attributeView.height = 450;
        _attributeView.y = self.view.height;
        _attributeView.backgroundColor = [UIColor whiteColor];
        
        // 添加加入购物车按钮
        UIButton *GWBtn = [[UIButton alloc]init];
        GWBtn.height = 40;
        GWBtn.width = JPScreenW;
        GWBtn.x = 0;
        GWBtn.y = _attributeView.height - GWBtn.height;
        [GWBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [GWBtn setTitleColor:Color(255, 255, 255) forState:UIControlStateNormal];
        [GWBtn addTarget:self action:@selector(gouwu) forControlEvents:UIControlEventTouchUpInside];
        GWBtn.backgroundColor = Color(250, 86, 87);
        [_attributeView addSubview:GWBtn];
        [_attributeView addSubview:self.attributeScrollView];
    }
    return _attributeView;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        
        
        [self.view addSubview:self.overlay];
        [self.view addSubview:self.attributeView];
        [UIView animateWithDuration:0.25 animations:^{
            self.overlay.y = 0;
            self.attributeView.y = self.view.height - self.attributeView.height;
        }completion:^(BOOL finished) {
            
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [DetailView height];
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
