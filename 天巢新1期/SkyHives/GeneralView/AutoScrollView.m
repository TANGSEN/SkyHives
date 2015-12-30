//
//  AutoScrollView.m
//  天巢新1期
//
//  Created by tangjp on 15/12/12.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "AutoScrollView.h"

#define CellIdentifier @"Cell"
#define MaxSections 20


@interface AutoScrollView ()
@property (nonatomic ,strong) UIPageControl *pageControl;
@property (nonatomic ,weak) NSTimer *timer;
@end

@implementation AutoScrollView

- (UIPageControl *)pageControl{
    if (!_pageControl){
        _pageControl = [[UIPageControl alloc]init];
    }
    return _pageControl;
}


- (void)setImages:(NSArray *)images{
    _images = images;
    if (images.count != 0) {
        [self addTimer];
        [self addPageControl];
    }
    
}


- (instancetype)initWithFrame:(CGRect)frame{
    // 创建一个布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 设置每一个item的宽高
    layout.itemSize = CGSizeMake(frame.size.width, frame.size.height);
    layout.minimumLineSpacing = 0;
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        self.pagingEnabled = YES;
        self.scrollEnabled = YES;
        self.backgroundColor = [UIColor yellowColor];
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
        
    }
    return self;
}



#pragma mark - 自定义方法
/**
 *  添加pageControl
 */
- (void)addPageControl{
//    [self.pageControl removeFromSuperview];
    self.pageControl.numberOfPages = self.images.count;
    self.pageControl.y = self.height - 20;
    self.pageControl.height = 20;
    self.pageControl.width = JPScreenW;
    self.pageControl.pageIndicatorTintColor = Color(240, 240, 240);
    self.pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
    [self.superview addSubview:self.pageControl];
}


#pragma mark - 定时器方法
/**
 *  添加定时器
 */
- (void)addTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

/**
 *  移除定时器
 */
- (void)removeTimer
{
    // 停止定时器
    [self.timer invalidate];
    self.timer = nil;
}
- (NSIndexPath *)resetIndexPath
{
    // 当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self indexPathsForVisibleItems] lastObject];
    // 马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:MaxSections/2];
    [self scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return currentIndexPathReset;
}

/**
 *  下一页
 */
- (void)nextPage
{
    // 1.马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    
    // 2.计算出下一个需要展示的位置
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == self.images.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    // 3.通过动画滚动到下一个位置
    [self scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return MaxSections;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *imageName = self.images[indexPath.item];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor purpleColor];
//    imageView.image = [UIImage imageNamed:imageName];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageName]];
    imageView.frame = CGRectMake(0, 0 , cell.contentView.width, cell.contentView.height);
    [cell.contentView addSubview:imageView];
    
    return cell;
}

#pragma mark  - UICollectionViewDelegate
/**
 *  当用户即将开始拖拽的时候就调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

/**
 *  当用户停止拖拽的时候就调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.Auto_delegate respondsToSelector:@selector(Auto_scrollViewDidScroll:)]) {
        [self.Auto_delegate Auto_scrollViewDidScroll:scrollView];
    }
    int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.images.count;
    self.pageControl.currentPage = page;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.Auto_delegate respondsToSelector:@selector(Auto_scrollView:didSelectItemAtIndexPath:)]) {
        [self.Auto_delegate Auto_scrollView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}

@end
