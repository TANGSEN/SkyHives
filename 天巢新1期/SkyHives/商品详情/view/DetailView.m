//
//  DetailView.m
//  天巢网
//
//  Created by tangjp on 15/11/17.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "DetailView.h"
#import "DetailScrollView.h"
#import "DetailDescriptionView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface DetailView () <UIScrollViewDelegate>
@property (nonatomic ,weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic ,strong) NSArray *photos;
@end

static CGFloat _height;

@implementation DetailView


- (instancetype)initWithImages:(NSArray *)images furniture:(Furniture *)furniture{
    if (self = [super init]) {
        self.photos = images;
        [self setupScrollViewWithImages:images];
        [self setupDescriptionViewWithFurniture:furniture];
        [self setupPageControl];
    }
    return self;
}

         
- (void)setupScrollViewWithImages:(NSArray *)images {
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.userInteractionEnabled = YES;
    CGFloat imageW = JPScreenW;
    CGFloat imageH = 200;
    NSInteger count = images.count;
    for (int i = 0; i < count; i ++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.userInteractionEnabled = YES;
        NSString *imageName = images[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"placehyolder"]];
        [scrollView addSubview:imageView];
        
        imageView.y = 0;
        imageView.width = imageW;
        imageView.height = imageH;
        imageView.x = i * imageW;
        imageView.tag = i;
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageView addGestureRecognizer:tap];
    }
    scrollView.contentSize = CGSizeMake(count * imageW, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = Color(246, 246, 246);
    scrollView.delegate = self;
    scrollView.width = JPScreenW;
    scrollView.height = 200;
    scrollView.x = 0;
    scrollView.y = 0;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    UIView *tapView = tap.view;
    // Photo -> MJPhoto
    int i = 0;
    NSMutableArray *arrM = [NSMutableArray array];
    // 为了使用MJPhotoBrowser , 需要将Photo -> MJPhoto
    for (NSString *photo in self.photos) {
        
        MJPhoto *p = [[MJPhoto alloc] init];
        p.url = [NSURL URLWithString:photo];
        p.index = i;
        p.srcImageView = (UIImageView *)tapView;
        [arrM addObject:p];
        i++;
    }
    
    
    // 弹出图片浏览器
    // 创建浏览器对象
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
    // MJPhoto
    brower.photos = arrM;
    brower.currentPhotoIndex = tapView.tag;
    [brower show];
}

- (void)setupDescriptionViewWithFurniture:(Furniture *)furniture{
    UIView *descriptionView = [[UIView alloc] init];
    
    // 商品标题
    UILabel *nameLabel  = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, JPScreenW - 60, 40)];
    [descriptionView addSubview:nameLabel];
    nameLabel.text = [@"  " stringByAppendingString:furniture.name];
    nameLabel.font = [UIFont boldSystemFontOfSize:12];
    nameLabel.textColor = [UIColor grayColor];
    nameLabel.numberOfLines = 2;
    
    // 商品标题和分享按钮之间的分割线
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame) + 10, 10, 0.5, 25)];
    label.backgroundColor = [UIColor grayColor];
    label.alpha = 0.7;
    [descriptionView addSubview:label];
    
    // 分享按钮
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame) + 20, 10, 50, 40)];
    UIImage *image = [UIImage imageNamed:@"icon_share"];
    btn.contentMode = UIViewContentModeScaleAspectFit;
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:@"分享" forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(20, -40, 0, 0)];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:10];
    btn.imageView.contentMode = UIViewContentModeScaleToFill;
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 20, 0)];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [descriptionView addSubview:btn];
    [btn bk_addEventHandler:^(id sender) {
        ShareView *view = [[ShareView alloc] initWithFrame:CGRectMake(0, ApplicationframeValue.height - 160, ApplicationframeValue.width, 160)];
        view.content = @"天巢网";
        view.message = @"快来挑选一下属于你的家具吧";
        view.shareUrl = @"https://www.skyhives.com/";
        [view show];
    } forControlEvents:UIControlEventTouchUpInside];
    
    // 价格标签是一个有属性的字符串
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(nameLabel.frame), JPScreenW / 2, 40)];
    NSString *str = [NSString stringWithFormat:@"￥%ld",(long)furniture.price];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, str.length)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(1, [NSString stringWithFormat:@"%ld",furniture.price].length)];
    priceLabel.attributedText = string;
    [descriptionView addSubview:priceLabel];
    
    // 销量标签 sales
    UILabel *salesLabel = [[UILabel alloc]initWithFrame:CGRectMake(JPScreenW / 2, priceLabel.y, JPScreenW / 2 - 15, priceLabel.height)];
    salesLabel.textColor = [UIColor grayColor];
    salesLabel.textAlignment = NSTextAlignmentRight;
    salesLabel.font = [UIFont boldSystemFontOfSize:10];
    NSString *salesStr = [NSString stringWithFormat:@"已售%ld",(long)furniture.sold_count];
    salesLabel.text = salesStr;
    [descriptionView addSubview:salesLabel];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(priceLabel.frame) + 10, JPScreenW - 20, 0.5)];
    label2.backgroundColor = [UIColor grayColor];
    label2.alpha = 0.7;
    [descriptionView addSubview:label2];
    
    // 优惠标签 preferential
    UILabel *preferentialLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, label2.y + 10, JPScreenW, 40)];
    preferentialLabel.numberOfLines = 0;
    NSString *preferentialStr = @"全国包邮\n上门安装";
    preferentialLabel.text = preferentialStr;
    preferentialLabel.textColor = [UIColor orangeColor];
    preferentialLabel.font = [UIFont boldSystemFontOfSize:12];
    [descriptionView addSubview:preferentialLabel];
    descriptionView.x = 0;
    descriptionView.y = CGRectGetMaxY(self.scrollView.frame);
    descriptionView.width = JPScreenW;
    descriptionView.height = CGRectGetMaxY(preferentialLabel.frame);
    [self addSubview:descriptionView];
    _height = CGRectGetMaxY(descriptionView.frame);
}

/**
 *  添加pageControl
 */
- (void)setupPageControl
{
    // 1.添加
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    NSInteger count = self.photos.count;
    pageControl.numberOfPages = count;
    pageControl.centerX = self.width * 0.5;
    pageControl.centerY = self.scrollView.height - 10;
    [self addSubview:pageControl];
    
    // 2.设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = Color(253, 98, 42); // 当前页的小圆点颜色
    pageControl.pageIndicatorTintColor = Color(189, 189, 189); // 非当前页的小圆点颜色
    self.pageControl = pageControl;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获得页码
    CGFloat doublePage = scrollView.contentOffset.x / scrollView.width;
    int intPage = (int)(doublePage + 0.5);
    
    // 设置页码
    self.pageControl.currentPage = intPage;
}

+ (CGFloat)height{
    return _height;
}


@end
