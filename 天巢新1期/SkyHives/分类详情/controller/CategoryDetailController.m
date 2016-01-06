//
//  CategoryDetailController.m
//  天巢新1期
//
//  Created by tangjp on 15/12/12.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "CategoryDetailController.h"
#import "GoodsTableView.h"
#import "FurnituresNetWork.h"
#import "FurnitureModel.h"
#import "HomeNetWork.h"

@interface CategoryDetailController () <TYGoodsTableDelegate , TYCollectionDelegate>
@property (nonatomic ,strong) NSArray *images;
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,weak) AutoScrollView *autoScrollView;
//@property (nonatomic ,weak) GoodsTableView *goodsTabelView;
@property (nonatomic ,weak) TYCollectionView *collectionView;
@property (nonatomic ,strong) NSArray *furnitureArray;
@property (nonatomic ,strong) FurnitureModel *furniture;
@property (nonatomic ,strong) NSArray *titles;
@property (nonatomic ,strong) GoodsTableView *goodsTabelView;
@end

@implementation CategoryDetailController

- (NSArray *)titles{
    if (!_titles){
        _titles = [[NSArray alloc]initWithObjects:@"[可可佳]简约现代书柜书架置物架简易柜子书柜实木柜",@"[SWEETNIGHT]进口乳胶床垫1.5  1.8米弹簧椰棕颜色齐全",@"[比尼贝尔]真皮沙发现代简约头层牛皮大小户型统统适用",@"[可可佳]简约现代书柜书架置物架简易柜子书柜实木柜",@"[SWEETNIGHT]进口乳胶床垫1.5  1.8米弹簧椰棕颜色齐全",@"[比尼贝尔]真皮沙发现代简约头层牛皮大小户型统统适用",@"[可可佳]简约现代书柜书架置物架简易柜子书柜实木柜",@"[SWEETNIGHT]进口乳胶床垫1.5  1.8米弹簧椰棕颜色齐全",@"[比尼贝尔]真皮沙发现代简约头层牛皮大小户型统统适用",@"[比尼贝尔]真皮沙发现代简约头层牛皮大小户型统统适用", nil];
    }
    return _titles;
}

- (GoodsTableView *)goodsTabelView{
    if (!_goodsTabelView){
        _goodsTabelView = [[GoodsTableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.autoScrollView.frame) + 10, JPScreenW, 0)];
    }
    return _goodsTabelView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, JPScreenW, JPScreenH)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}

- (NSArray *)images{
    if (!_images) {
        _images = [NSArray arrayWithObjects:@"zhuolei",@"chaji",/*@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",*/ nil];
    }return _images;
}

- (instancetype)initWithType:(FurnitureType)type{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.scrollView];
    
    [self setupDownRefresh];
    
    [self setupAutoScrollView];
    
    
}

- (void)setupAutoScrollView{
    AutoScrollView *scrollView = [[AutoScrollView alloc]initWithFrame:CGRectMake(0, 0, JPScreenW, JPScreenH / 4)];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [HomeNetWork getAdcertisementWithBlock:^(NSArray *model, NSError *error) {
        [model enumerateObjectsUsingBlock:^(AdvertisementModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [array addObject:obj.thumb];
        }];
        scrollView.images = array;
        [scrollView reloadData];
    }];
    [self.scrollView addSubview:scrollView];
    self.autoScrollView = scrollView;
}

/**
 *  集成下拉刷新控件
 *  使用了 MJRefresh 第三方框架
 */
- (void)setupDownRefresh
{
    self.scrollView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 加载数据
    [self setupGoodsTable];
    }];
    
    [self.scrollView.mj_header beginRefreshing];
}

- (void)setupGoodsTable{
    
        [FurnituresNetWork getFurnituresWithFurnitureType:(FurnitureType)_type block:^(NSArray *models, NSError *error) {
            
            self.goodsTabelView.TYGoods_delegate = self;
            self.goodsTabelView.furnitures = models;
            self.goodsTabelView.cellCount = models.count;
            self.goodsTabelView.height = [self.goodsTabelView height];
            [self.scrollView addSubview:self.goodsTabelView];
            [self.scrollView.mj_header endRefreshing];
            [self setupMoreWonderful];
        }];
}

- (void)setupMoreWonderful{
    
    [FurnituresNetWork getSeeAgainWithFurnitureType:_type block:^(NSArray *models, NSError *error) {
        if (models.count != 0) {
            // 添加看了又看标题
            UILabel *seeTitleL = [[UILabel alloc]init];
            seeTitleL.backgroundColor = [UIColor whiteColor];
            
            seeTitleL.text = @"  更多精彩";
            seeTitleL.frame = CGRectMake(0, CGRectGetMaxY(self.goodsTabelView.frame) + 10, JPScreenW, 30);
            seeTitleL.textColor = Color(255, 65, 67);
            seeTitleL.font = [UIFont boldSystemFontOfSize:20];
            seeTitleL.textAlignment = NSTextAlignmentCenter;
            [self.scrollView addSubview:seeTitleL];
            
            // 添加看了又看模块
            TYCollectionView *collectionView = [[TYCollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(seeTitleL.frame), JPScreenW, [TYCollectionView height])];
            collectionView.furnitures = models;
            collectionView.itemCount = (int)models.count;
            collectionView.height = [collectionView height];
            collectionView.TY_delegate = self;
            self.collectionView = collectionView;
            [self.scrollView addSubview:collectionView];
            
            self.scrollView.contentSize = CGSizeMake(JPScreenW, CGRectGetMaxY(self.collectionView.frame));
        }
        
    }];
    
    

}

/**
 *  推出商品详情页面
 */
- (void)pushDetailViewControllerWithFurniture:(FurnitureModel *)furniture{
    TCDetailController *detailVc = [[TCDetailController alloc]init];
    detailVc.furniture = furniture;
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (void)TYGoods_tableView:(GoodsTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushDetailViewControllerWithFurniture:tableView.furnitures[indexPath.row]];
}

- (void)TY_collectionView:(TYCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self pushDetailViewControllerWithFurniture:collectionView.furnitures[indexPath.item]];
}

@end
