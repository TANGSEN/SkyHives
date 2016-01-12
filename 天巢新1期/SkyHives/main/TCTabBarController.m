//
//  TCTabBarController.m
//  天巢网
//
//  Created by tangjp on 15/11/10.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "TCTabBarController.h"
#import "TCHomeViewController.h"
#import "TCCategoryController.h"
#import "TCProfileController.h"
#import "TCNavigationController.h"
#import "MyShoppingController.h"

@interface TCTabBarController ()

@end

@implementation TCTabBarController

- (id)init
{
    if (self = [super init]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            // 加载资源
            
        });
    }
    return self;
}
//singleton_m(TabBarController)

/**
 *  重写父类的setSelectedIndex方法,在父类调用之前获取最后一次选中的位置
 *
 *  @param selectedIndex 当前选中的位置
 */
-(void)setSelectedIndex:(NSUInteger)selectedIndex
{
    // 用户手动设置的时候
    self.lastSelectedIndex = self.selectedIndex;
    
    //调用父类的setSelectedIndex
    [super setSelectedIndex:selectedIndex];
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    // 用户点击了tabbar某一项的时候
    _lastSelectedIndex = self.selectedIndex;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    TCHomeViewController *homeVC = [[TCHomeViewController alloc]init];
    [self addChildVc:homeVC Title:@"首页" Image:@"tab_icon_home_default" SelectedImage:@"tab_icon_home_selected"];
    
    
    TCCategoryController *cateVC = [[TCCategoryController alloc]init];
    [self addChildVc:cateVC Title:@"分类" Image:@"tab_icon_category_default" SelectedImage:@"tab_icon_category_selected"];
    
    MyShoppingController *shopVC = [[MyShoppingController alloc]init];
    
    [self addChildVc:shopVC Title:@"购物车" Image:@"tab_icon_shopping_default" SelectedImage:@"tab_icon_shopping_selected"];
    
    TCProfileController *profileVC = [[TCProfileController alloc]init];
    [self addChildVc:profileVC Title:@"个人中心" Image:@"tab_icon_profile_default" SelectedImage:@"tab_icon_profile_select"];
    
    [self.tabBar setTintColor:[UIColor redColor]];
    
}



/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中后的图片
 */
- (void)addChildVc:(UIViewController *)childVc Title:(NSString *)title Image:(NSString *)image SelectedImage:(NSString *)selectedImage {
    // 设置子控制器的文字和图片
    //childVc.tabBarItem.title = title;  // 设置 tabbar 的文字
    //childVc.navigationItem.title = title; // 设置 navigationBar 的文字
    childVc.title = title; // 同时设置 tabbar 和 navigationBar 的文字
    // 设置控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //     设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    // 先给外面传进来的小控制器, 包装 一个导航控制器
    TCNavigationController *nav = [[TCNavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
}
@end
