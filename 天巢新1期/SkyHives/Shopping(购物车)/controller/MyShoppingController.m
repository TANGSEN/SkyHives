//
//  MyShoppingController.m
//  天巢网
//
//  Created by 赵贺 on 15/11/24.
//  Copyright © 2015年 tangjp. All rights reserved.
//

/**
 
 1、cell 内
 ·选择按钮需要即时刷新总价（改变数据源，重新reload）
 ·stepper 加减 需要改变的是数量，（改变数据源数量）
 ①如果此时按钮是选中状态，总价需要变化
 ②非选择状态，则不需要
 ·删除按钮需要改变数据源，页面即时刷新（包括总价，视图）
 
 2、全选按钮 改变的是总价  直接对数据源遍历
 
 3、结算按钮 如果总价为0，则不能点击
 结算之前对数据源进行遍历，传递商品详情
 
 4、有一个按钮没选择的话 下面的全选按钮的状态应该变为 未选中状态
 
 接口	http://www.skyhives.com/ping/ppay
 输入参数	oid（订单id）
	channel（支付渠道，选项有：
 alipay: 支付宝手机支付；
 wx:微信支付
 更多请参考ping++官方文档
 ）
	tag（1：支付  2：取消）
 返
 回
 值	status（修改状态:1 成功 0 失败）
	data（返回charge对象）
	msg(消息提示)
 例子	http://www.skyhives.com/ping/ppay?oid=123&&channel= wx&&tag=1
 
 
 */




#import "MyShoppingController.h"
#import "TCShoppingTable.h"
#import "MyShoppingCell.h"
#import "ShoppingModel.h"
#import "TCTabBarController.h"
#import "Pingpp.h"

#define CELLH 100.0f

static NSString *kBackendChargeURL = @"www.skyhives.com";

@interface MyShoppingController () <CustomerDelegate , TYCollectionDelegate>
@property (nonatomic,strong)ShoppingModel *model;
@property (nonatomic,strong)MyShoppingCell *cell;

@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) CustomerView *topView;
@property (nonatomic ,strong) TYCollectionView *collectionView;

@property (nonatomic ,strong) NSArray *titles;
@property (nonatomic ,strong) NSArray *titles2;

/**数据*/
@property (nonatomic,strong)NSMutableArray *arr;
/**cell视图*/
@property (nonatomic,strong)UITableView *table;
@property (assign, nonatomic) NSInteger PreSum;

@property (assign,nonatomic)   NSUInteger  SelectedNumber;
@property (nonatomic, retain) NSArray *itemCounts;
@property (nonatomic,strong)UIButton *BottomButton;

@end

@implementation MyShoppingController

#pragma mark - lazy loading
-(NSMutableArray *)arr
{
    if (!_arr) {
        _arr = [ShoppingModel demoData];
    }
    return _arr;
}

- (NSArray *)titles{
    if (!_titles){
        _titles = [[NSArray alloc]initWithObjects:@"[可可佳]简约现代书柜书架置物架简易柜子书柜实木柜",@"[SWEETNIGHT]进口乳胶床垫1.5  1.8米弹簧椰棕颜色齐全",@"[比尼贝尔]真皮沙发现代简约头层牛皮大小户型统统适用",@"[可可佳]简约现代书柜书架置物架简易柜子书柜实木柜",@"[SWEETNIGHT]进口乳胶床垫1.5  1.8米弹簧椰棕颜色齐全",@"[比尼贝尔]真皮沙发现代简约头层牛皮大小户型统统适用",@"[可可佳]简约现代书柜书架置物架简易柜子书柜实木柜",@"[SWEETNIGHT]进口乳胶床垫1.5  1.8米弹簧椰棕颜色齐全",@"[比尼贝尔]真皮沙发现代简约头层牛皮大小户型统统适用",@"[比尼贝尔]真皮沙发现代简约头层牛皮大小户型统统适用", nil];
    }
    return _titles;
}

- (NSArray *)titles2{
    if (!_titles2){
        _titles2 = [[NSArray alloc]initWithObjects:@"简约现代书柜书架置物架简易柜子书柜实木柜",@"进口乳胶床垫1.5  1.8米弹簧椰棕颜色齐全",@"真皮沙发现代简约头层牛皮大小户型统统适用",@"简约现代书柜书架置物架简易柜子书柜实木柜",@"进口乳胶床垫1.5  1.8米弹簧椰棕颜色齐全",@"真皮沙发现代简约头层牛皮大小户型统统适用",@"简约现代书柜书架置物架简易柜子书柜实木柜",@"进口乳胶床垫1.5  1.8米弹簧椰棕颜色齐全",@"真皮沙发现代简约头层牛皮大小户型统统适用",@"真皮沙发现代简约头层牛皮大小户型统统适用", nil];
    }
    return _titles2;
}

-(NSInteger)PreSum
{
    if (!_PreSum) {
        _PreSum = 0;
    }
    return _PreSum;
}

-(NSUInteger)SelectedNumber
{
    if (!_SelectedNumber) {
        _SelectedNumber = 0 ;
    }
    return _SelectedNumber;
}

- (UIScrollView *)scrollView{
    if (!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, JPScreenW, JPScreenH-45)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}

- (CustomerView *)topView{
    if (!_topView){
        _topView = [[CustomerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.table.frame) + 10, JPScreenW, 47) initButWithArray:[NSArray arrayWithObjects:@"今日最受欢迎",@"大家还买了",nil] butFont:(NSInteger)14 selectedIndex:0];
        _topView.delegate = self;
        _topView.clipsToBounds = YES;
    }
    
    return _topView;
}

- (TYCollectionView *)collectionView{
    if (!_collectionView){
        // 添加大家还买了和今日最受欢迎
        _collectionView = [[TYCollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), JPScreenW, [TYCollectionView height])];
//        _collectionView.titles = self.titles;
        _collectionView.TY_delegate = self;
        
        
    }
    _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_collectionView.frame));
    return _collectionView;
}

#pragma mark - TYCollectionDelegate
- (void)TY_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TCDetailController *detailVc = [[TCDetailController alloc]init];
    [self.navigationController pushViewController:detailVc animated:YES];
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
//            self.collectionView.titles = self.titles;
            NSLog(@"今日最受欢迎");
            break;
        case 2:
//            self.collectionView.titles = self.titles2;
            NSLog(@"大家还买了");
        default:
            break;
    }
    
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Pingpp setDebugMode:YES];
    
    
    
    // 添加最底层的scrollView
    [self.view addSubview:self.scrollView];

    
    self.PreSumLabel.text = @"￥0";
    

    [self setupBottomButton];
    
    [self setupTableView];
    
//    [self countButtonClick];

//    [self.scrollView addSubview:self.topView];
    
//    [self.scrollView addSubview:self.collectionView];
}
/**
 *  配置tableView
 */
- (void)setupTableView{
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ApplicationframeValue.width, CELLH * self.arr.count)];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.scrollView addSubview:self.table];
    _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.table.frame));
}

/**
 *  设置底部的全选按钮
 */
- (void)setupBottomButton{
    /**全选按钮*/
    UIButton *BottomButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.BottomView addSubview:BottomButton];
    [BottomButton setBackgroundImage:[UIImage imageNamed:@"shopping_icon_default"] forState:UIControlStateNormal];
    [BottomButton setBackgroundImage:[UIImage imageNamed:@"shopping_icon_select"] forState:UIControlStateSelected];
    self.BottomButton = BottomButton;
        [BottomButton bk_addEventHandler:^(id sender) {
            BottomButton.selected = !BottomButton.selected;
            if (BottomButton.selected == YES) {
                self.PreSum = 0;
                self.SelectedNumber = self.arr.count;
                for (ShoppingModel *model in self.arr) {
                    model.Selected = YES;
                    self.PreSum += [model.Price integerValue]*[model.Count integerValue];
                    self.PreSumLabel.text = [NSString stringWithFormat:@"￥%ld",(long)self.PreSum];
                    NSLog(@"%ld",(long)self.PreSum);
    
                }
            }else
            {
                self.SelectedNumber = 0;
                for (ShoppingModel *model in self.arr) {
                    model.Selected = NO;
                    self.PreSum = 0;
                    self.PreSumLabel.text = [NSString stringWithFormat:@"￥%ld",(long)self.PreSum];
                }
    
            }
    
            self.PreSumLabel.text = [NSString stringWithFormat:@"￥%ld",(long)self.PreSum];
            
            [self.table reloadData];
        } forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  支付调用接口(支付宝/微信)
 *
 *  @param charge           Charge 对象(JSON 格式字符串)
 *  @param scheme           URL Scheme，支付宝渠道回调需要，没有支付宝情况下可为 nil
 *  @param completionBlock  支付结果回调 Block
 */
//- (IBAction)countBtnClick:(UIButton *)sender {
//    
//    [Pingpp createPayment:<#(NSString *)#> appURLScheme:<#(NSString *)#> withCompletion:<#^(NSString *result, PingppError *error)completion#>];
//}

/**
 *  结算按钮点击事件
 */
- (void)countButtonClick{
    /**结算按钮*/
    
    /*
     接口	http://www.skyhives.com/ping/ppay
     输入参数	oid（订单id）
     channel（支付渠道，选项有：
     alipay: 支付宝手机支付；
     wx:微信支付
     更多请参考ping++官方文档
     ）
     tag（1：支付  2：取消）
     返
     回
     值	status（修改状态:1 成功 0 失败）
     data（返回charge对象）
     msg(消息提示)
     例子	http://www.skyhives.com/ping/ppay?oid=123&&channel= wx&&tag=1
     */
    

    
    
        [self.CountButton bk_addEventHandler:^(id sender) {
        if (self.PreSum!=0) {
                NSString *orderNo = [MyShoppingController rand_str:12]; // orderNo 一般在服务器生成
    
//                        NSArray *contents = @[
//                                              @[@"商品", @[@"Kaico 搪瓷水壶 x 1", @"橡胶花瓶 x 1", @"扫把和簸箕 x 1"]],
//                                              @[@"运费", @[@"¥ 0.00"]]
//                                            ];
                [Pingpp payWithOrderNo:orderNo amount:self.PreSum*100 display:nil serverURL:kBackendChargeURL customParams:nil appURLScheme:@"wx25d9ec509a6dbfca" viewController:self completionHandler:^(NSString *result, PingppError *error) {
                    NSLog(@">>>>>>> %@", result);
                }];
            }
        } forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 产生随机订单号
+ (NSString *)rand_str:(int) l {
    char pool[] = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    char data[l];
    for (int x=0;x<l;data[x++] = (char)(pool[arc4random_uniform(62)]));
    return [[NSString alloc] initWithBytes:data length:l encoding:NSUTF8StringEncoding];
}




#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingModel *model = self.arr[indexPath.row];
    static NSString *ID  = @"cell";
    MyShoppingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyShoppingCell" owner:self options:nil] lastObject];
    }
    UIButton *ChooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ChooseButton.imageView.contentMode = UIViewContentModeScaleToFill;
    ChooseButton.height = 40;
    ChooseButton.width = 40;
    ChooseButton.x = 0;
    ChooseButton.y = (CELLH - ChooseButton.height) / 2;
    [ChooseButton setBackgroundImage:[UIImage imageNamed:@"shopping_icon_default"] forState:UIControlStateNormal];
    [ChooseButton setBackgroundImage:[UIImage imageNamed:@"shopping_icon_select"] forState:UIControlStateSelected];
    ChooseButton.tag = indexPath.row;
    
    [cell.contentView addSubview:ChooseButton];
    ChooseButton.selected = model.Selected;
    
    [ChooseButton bk_addEventHandler:^(id sender) {
        
        model.Selected = !model.Selected;
        if (model.Selected) {
            self.PreSum += [model.Price integerValue]*[model.Count integerValue];
            self.SelectedNumber += 1;
            if (self.SelectedNumber==self.arr.count) {
                self.BottomButton.selected = YES;
            }

            NSLog(@"%ld",(long)self.PreSum);
            
            self.PreSumLabel.text = [NSString stringWithFormat:@"￥%ld",(long)self.PreSum];
        }else
        {
            self.PreSum -= [model.Price integerValue]*[model.Count integerValue];;
            
            self.SelectedNumber -= 1;
            if (self.SelectedNumber!=self.arr.count) {
                self.BottomButton.selected = NO;
            }
            NSLog(@"%ld",(long)self.PreSum);
            self.PreSumLabel.text = [NSString stringWithFormat:@"￥%ld",(long)self.PreSum];
            
        }
        [self.table reloadData];
    } forControlEvents:UIControlEventTouchUpInside];
    
    cell.Count.text = model.Count;
    cell.PriceLabel.text =[NSString stringWithFormat:@"￥%@",model.Price];
    cell.ProductDetailLabel.text = model.ProductName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self getRoundCorner:cell.StepperView];
    cell.Imageline1.backgroundColor = [UIColor lightGrayColor];
    cell.Imageline2.backgroundColor = [UIColor lightGrayColor];
    
    [cell.PlusButton bk_addEventHandler:^(id sender) {
        model.Count = [NSString stringWithFormat:@"%ld",[model.Count integerValue]+1];
        if (model.Selected) {
            self.PreSum += [model.Price integerValue];
            self.PreSumLabel.text = [NSString stringWithFormat:@"￥%ld",(long)self.PreSum];
        }
        cell.Count.text = [NSString stringWithFormat:@"%ld",(long)[model.Count integerValue]];
        [self.table reloadData];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [cell.DecreaseButton bk_addEventHandler:^(id sender) {
        if ([model.Count integerValue]==1) {
            return ;
        }
        model.Count = [NSString stringWithFormat:@"%ld",[model.Count integerValue]-1];
        
        cell.Count.text = [NSString stringWithFormat:@"%ld",(long)[model.Count integerValue]];
        if (model.Selected) {
            
            self.PreSum -= [model.Price integerValue];
            
            self.PreSumLabel.text = [NSString stringWithFormat:@"￥%ld",(long)self.PreSum];
        }
        [self.table reloadData];
    } forControlEvents:UIControlEventTouchUpInside];
    return cell;
}



#pragma mark - tableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TCDetailController *detailVc = [[TCDetailController alloc]init];
    [self.navigationController pushViewController:detailVc animated:YES];
    
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView setEditing:YES animated:YES];
    return UITableViewCellEditingStyleDelete;
}

//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.arr removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CGRect rect = CGRectMake(0, 0, ApplicationframeValue.width, CELLH * self.arr.count);
            tableView.frame = rect;
            [UIView animateWithDuration:0.25 animations:^{
                if (self.arr.count == 0) {
                    return ;
                }
                self.topView.y -= CELLH;
                self.collectionView.y = CGRectGetMaxY(self.topView.frame);
            }];
        });
    }
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, JPScreenW, 60)];
    label.text = @"购物车是空的, 去逛逛吧";
    label.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [label addGestureRecognizer:tap];
    label.userInteractionEnabled = YES;
    [self.scrollView addSubview:label];
    if (self.arr.count == 0) {
        label.hidden = NO;
        self.BottomView.hidden = YES;
    }else{
        label.hidden = YES;
        self.BottomView.hidden = NO;
    }
}

- (void)tap{
    TCTabBarController *tabbarVc = (TCTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    tabbarVc.selectedIndex = 0;
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(UIView *)getRoundCorner:(UIView *)vView
{
    
    vView.layer.borderWidth  = 0.8f;
    vView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
    vView.layer.cornerRadius = 3.0f;
    [vView.layer setMasksToBounds:YES];
    
    
    return nil;
    
    
}




@end
