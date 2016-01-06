//
//  TCHomeViewController.m
//  天巢网
//
//  Created by tangjp on 15/11/10.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "TCHomeViewController.h"
#import "CategoryDetailController.h"
#import "ChannelView.h"
#import "TCTabBarController.h"
#import "HomeNetWork.h"



@interface TCHomeViewController () <TYTableDelegate , TYCollectionDelegate, UITabBarControllerDelegate>
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) TYTableView *tmTableView;
@property (nonatomic ,strong) TYTableView *tzTableView;
@property (nonatomic ,strong) TYCollectionView *collectionView;
@property (nonatomic ,strong) ChannelView *channelView;
@property (nonatomic ,strong) NSArray *names;
@property (nonatomic ,strong) NSArray *channelImages;
@property (nonatomic ,strong) NSArray *tmImages;
@property (nonatomic ,strong) NSArray *tzImages;

@property (nonatomic ,strong) NSMutableArray *array;

@property (nonatomic ,strong) TCTabBarController *tabbarVC;

@property (nonatomic ,strong) UITapGestureRecognizer *tap;

@end

@implementation TCHomeViewController

#pragma mark - 懒加载

- (UIScrollView *)scrollView{
    if (!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, JPScreenW, JPScreenH)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}



// channel按钮的title
- (NSArray *)names{
    if (!_names) {
        _names = [NSArray arrayWithObjects:@"闪购",@"特卖",@"实景体验",@"虚拟体验", nil];
    }
    return _names;
}


- (NSArray *)channelImages{
    if (!_channelImages) {
        _channelImages = [NSArray arrayWithObjects:@"button_bangongshi",@"button_chufan",@"button_ertongfang",@"button_keting", nil];
    }
    return _channelImages;
}

- (NSArray *)tmImages{
    if (!_tmImages){
        _tmImages = [[NSArray alloc]initWithObjects:@"baoju",@"chaji",@"dachuang",@"ertong",@"guilei",@"shipin",@"zhuolei",@"zuoju",@"baoju",@"chaji", nil];
    
    }
    return _tmImages;
}

- (NSArray *)tzImages{
    if (!_tzImages){
        _tzImages = [[NSArray alloc]initWithObjects:@"cantingtaozhuang",@"ketingtaozhuang",@"cantingtaozhuang",@"ketingtaozhuang",@"cantingtaozhuang", nil];
    }
    return _tzImages;
}

#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(TCTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    // 点击首页返回屏幕顶部
    if (tabBarController.lastSelectedIndex == self.tabBarController.selectedIndex ) {
        [self.scrollView setContentOffset:CGPointZero animated:YES];
    }
}

#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置自己的tababrController的delegate为自己
    self.tabBarController.delegate = self;
    
    // 设置导航栏右边的按钮
    [self setupRightBarBtn];
    
    // 设置scrollView不会自动适配
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 设置导航栏左边的按钮
    [self setupLeftBarBtn];
    
    // 添加顶部自动滚动广告
    AutoScrollView *scrollView = [[AutoScrollView alloc]initWithFrame:CGRectMake(0, 0, JPScreenW, JPScreenH / 4)];
    scrollView.scrollsToTop = NO;
    self.array = [[NSMutableArray alloc]init];
    [HomeNetWork getAdcertisementWithBlock:^(NSArray *model, NSError *error) {
        [model enumerateObjectsUsingBlock:^(AdvertisementModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.array addObject:obj.thumb];
        }];
        scrollView.images = self.array;
        [scrollView reloadData];
    }];
    [self.scrollView addSubview:scrollView];
    ChannelView *channelView = [[ChannelView  alloc]init];
    channelView.userInteractionEnabled = YES;
    channelView.backgroundColor = [UIColor whiteColor];
    CGRect rect = CGRectMake(0, CGRectGetMaxY(scrollView.frame) + 10, JPScreenW, 70);
    channelView.frame = rect;
    channelView.cols = 4;
    channelView.rows = 1;
    channelView.channelImagesAndNames = @[self.channelImages,self.names];
    [self.scrollView addSubview:channelView];
    
    for (UIView *subview  in channelView.subviews) {
        
        if (subview.tag == 2) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClick)];
            [subview addGestureRecognizer:tap];
        }else{
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGR)];
            [subview addGestureRecognizer:tap];
        }
    }
    self.channelView = channelView;
    
    // 添加今日特卖标题
    UILabel *tmTitleL = [[UILabel alloc]init];
    tmTitleL.backgroundColor = [UIColor whiteColor];
    tmTitleL.frame = CGRectMake(0, CGRectGetMaxY(channelView.frame) + 10, JPScreenW, 30);
    tmTitleL.text = @"今日特卖";
    tmTitleL.textColor = Color(255, 65, 67);
    tmTitleL.font = [UIFont boldSystemFontOfSize:15];
    tmTitleL.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:tmTitleL];

    // 添加今日特卖模块
    TYTableView *tmTableView = [[TYTableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tmTitleL.frame), JPScreenW, 0) style:UITableViewStylePlain];
    tmTableView.scrollsToTop = NO;
    tmTableView.TY_delegate = self;
    tmTableView.cellCount = 8;
    tmTableView.height = [tmTableView height];
    tmTableView.images = self.tmImages;
    self.tmTableView = tmTableView;
    [self.scrollView addSubview:tmTableView];
    
    // 添加套装标题
    UILabel *tzTitleL = [[UILabel alloc]init];
    tzTitleL.backgroundColor = [UIColor whiteColor];
    tzTitleL.frame = CGRectMake(0, CGRectGetMaxY(tmTableView.frame) + 10, JPScreenW, 30);
    tzTitleL.text = @"we are 伐木累";
    tzTitleL.textColor = Color(255, 65, 67);
    tzTitleL.font = [UIFont boldSystemFontOfSize:15];
    tzTitleL.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:tzTitleL];
    
    // 添加套装模块
    TYTableView *tzTableView = [[TYTableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tzTitleL.frame), JPScreenW, 0) style:UITableViewStylePlain];
    tzTableView.scrollsToTop = NO;
    tzTableView.TY_delegate = self;
    tzTableView.cellCount = 5;
    tzTableView.height = [tzTableView height];
    tzTableView.images = self.tzImages;
    self.tzTableView = tzTableView;
    [self.scrollView addSubview:tzTableView];
    
    // 添加看了又看标题
    UILabel *seeTitleL = [[UILabel alloc]init];
    seeTitleL.backgroundColor = [UIColor whiteColor];
    
    seeTitleL.text = @"  看了又看";
    seeTitleL.frame = CGRectMake(0, CGRectGetMaxY(tzTableView.frame) + 10, JPScreenW, 30);
    seeTitleL.textColor = Color(255, 65, 67);
    seeTitleL.font = [UIFont boldSystemFontOfSize:15];
    [self.scrollView addSubview:seeTitleL];
    
    // 添加看了又看模块
    [HomeNetWork getSeeAgainFurnitureWithblock:^(NSArray *models, NSError *error) {
        TYCollectionView *collectionView = [[TYCollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(seeTitleL.frame), JPScreenW, 0)];
        collectionView.scrollsToTop = NO;
        collectionView.furnitures = models;
        collectionView.itemCount = (int)models.count;
        collectionView.height = [collectionView height];
        collectionView.TY_delegate = self;
        [collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        self.collectionView = collectionView;
        [self.scrollView addSubview:collectionView];
        self.scrollView.contentSize = CGSizeMake(JPScreenW, CGRectGetMaxY(collectionView.frame));
    }];
    
    [self.view addSubview:self.scrollView];
    
}

- (void)btnClick{
//    JXMainViewController *mainVC = [[JXMainViewController alloc]initWithNibName:@"JXMainViewController" bundle:nil];
//    [self presentViewController:mainVC animated:YES completion:nil];
}

- (void)tapGR{
    [self showSuccessMsg:@"该功能暂未开通,敬请期待"];
}



#pragma mark - 自定义方法
/**
 *  设置导航栏右边的按钮
 */
- (void)setupRightBarBtn{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"实景体验" style:0 target:self action:@selector(rightBarButtonItemCilck)];
}

- (void)rightBarButtonItemCilck{
//    JXMainViewController *mainVC = [[JXMainViewController alloc] initWithNibName:@"JXMainViewController" bundle:nil];
//    [self presentViewController:mainVC animated:YES completion:nil];
}

- (void)setupLeftBarBtn{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"虚拟体验" style:0 target:self action:@selector(leftBarButtonItemCilck)];
}

- (void)leftBarButtonItemCilck{
    
    [self showSuccessMsg:@"该功能暂未开通,敬请期待"];
}

#pragma mark - TYTableDelegate
- (void)TY_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tmTableView) {
        CategoryDetailController *cateVc = [[CategoryDetailController alloc]initWithType:indexPath.row];
        cateVc.title = @"特卖会场";
        [self.navigationController pushViewController:cateVc animated:YES];
    }else if (tableView == self.tzTableView){
        [self showSuccessMsg:@"该功能暂未开通,敬请期待"];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TYCollectionDelegate
- (void)TY_collectionView:(TYCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TCDetailController *detailVc = [[TCDetailController alloc]init];
    detailVc.furniture = collectionView.furnitures[indexPath.item];
    
    [self.navigationController pushViewController:detailVc animated:YES];
    
}


















@end
