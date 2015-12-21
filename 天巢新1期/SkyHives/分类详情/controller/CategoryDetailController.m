//
//  CategoryDetailController.m
//  天巢新1期
//
//  Created by tangjp on 15/12/12.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "CategoryDetailController.h"
#import "GoodsTableView.h"

@interface CategoryDetailController () <TYGoodsTableDelegate , TYCollectionDelegate>
@property (nonatomic ,strong) NSArray *images;
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,weak) AutoScrollView *autoScrollView;
@property (nonatomic ,weak) GoodsTableView *goodsTabelView;
@property (nonatomic ,weak) TYCollectionView *collectionView;
@property (nonatomic ,strong) NSArray *titles;
@end

@implementation CategoryDetailController

- (NSArray *)titles{
    if (!_titles){
        _titles = [[NSArray alloc]initWithObjects:@"[可可佳]简约现代书柜书架置物架简易柜子书柜实木柜",@"[SWEETNIGHT]进口乳胶床垫1.5  1.8米弹簧椰棕颜色齐全",@"[比尼贝尔]真皮沙发现代简约头层牛皮大小户型统统适用",@"[可可佳]简约现代书柜书架置物架简易柜子书柜实木柜",@"[SWEETNIGHT]进口乳胶床垫1.5  1.8米弹簧椰棕颜色齐全",@"[比尼贝尔]真皮沙发现代简约头层牛皮大小户型统统适用",@"[可可佳]简约现代书柜书架置物架简易柜子书柜实木柜",@"[SWEETNIGHT]进口乳胶床垫1.5  1.8米弹簧椰棕颜色齐全",@"[比尼贝尔]真皮沙发现代简约头层牛皮大小户型统统适用",@"[比尼贝尔]真皮沙发现代简约头层牛皮大小户型统统适用", nil];
    }
    return _titles;
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



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    [self setupAutoScrollView];
    [self setupGoodsTable];
    [self setupMoreWonderful];
    self.scrollView.contentSize = CGSizeMake(JPScreenW, CGRectGetMaxY(self.collectionView.frame));
}

- (void)setupAutoScrollView{
    AutoScrollView *scrollView = [[AutoScrollView alloc]initWithFrame:CGRectMake(0, 0, JPScreenW, JPScreenH / 4)];
    [self.scrollView addSubview:scrollView];
    scrollView.images = self.images;
    self.autoScrollView = scrollView;
}


- (void)setupGoodsTable{
    GoodsTableView *goodsTabelView = [[GoodsTableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.autoScrollView.frame) + 10, JPScreenW, 0)];
    goodsTabelView.TYGoods_delegate = self;
    goodsTabelView.cellCount = 10;
    goodsTabelView.height = [goodsTabelView height];
//    goodsTabelView.images = self.tmImages;
    self.goodsTabelView = goodsTabelView;
    [self.scrollView addSubview:goodsTabelView];
}

- (void)setupMoreWonderful{
    // 添加看了又看标题
    UILabel *seeTitleL = [[UILabel alloc]init];
    seeTitleL.backgroundColor = [UIColor whiteColor];
    
    seeTitleL.text = @"  更多精彩";
    seeTitleL.frame = CGRectMake(0, CGRectGetMaxY(self.goodsTabelView.frame) + 10, JPScreenW, 30);
    seeTitleL.textColor = Color(255, 65, 67);
    seeTitleL.backgroundColor = RandomColor;
    seeTitleL.font = [UIFont boldSystemFontOfSize:20];
    seeTitleL.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:seeTitleL];
    
    // 添加看了又看模块
    TYCollectionView *collectionView = [[TYCollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(seeTitleL.frame), JPScreenW, [TYCollectionView height])];
    collectionView.titles = self.titles;
    collectionView.TY_delegate = self;
    self.collectionView = collectionView;
    [self.scrollView addSubview:collectionView];

}

/**
 *  推出商品详情页面
 */
- (void)pushDetailViewController{
    TCDetailController *detailVc = [[TCDetailController alloc]init];
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (void)TYGoods_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushDetailViewController];
}

- (void)TY_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self pushDetailViewController];
}

@end
