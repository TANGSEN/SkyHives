//
//  TYCollectionView.m
//  Unity-iPhone
//
//  Created by tangjp on 15/12/10.
//
//

#import "TYCollectionView.h"
#import "TYCollectionViewCell.h"

#define ItemH 220
#define ItemW (JPScreenW - 0) / 2
#define ItemSize CGSizeMake(ItemW, ItemH)

static NSString * const reuseIdentifier = @"Cell";

@implementation TYCollectionView

/**
 *  初始化
 *
 *  @param frame 坐标位置
 *
 *  @return 当前实例
 */
- (instancetype)initWithFrame:(CGRect)frame{
    // 创建一个布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置每一个item的宽高
    layout.itemSize = ItemSize;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0;
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = YES;
        self.bounces = NO;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[TYCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    return self;
}



#pragma mark <UICollectionViewDataSource>

/**
 *  有多少个分区
 *
 *  @param collectionView collectionView
 *
 *  @return 分区数
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

/**
 *  每个分区有多少项
 *
 *  @param collectionView collectionView
 *  @param section        section
 *
 *  @return item个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_itemCount == 0) {
        return 10;
    }
    return _itemCount;
}

/**
 *  每个item的样子
 *
 *  @param collectionView collectionView
 *  @param indexPath      indexPath
 *
 *  @return item
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    for (UIView *subView in cell.contentView.subviews)
    {
        [subView removeFromSuperview];
    }
    if (self.furnitures.count == 0) {
        cell.title = self.titles[indexPath.item];
        cell.price = rand() % 100;
        cell.sales = rand() % 100;
        cell.imageName = @"placehyolder";
    }else{
        cell.furniture = self.furnitures[indexPath.item];
    }
    
    return cell;
}

- (void)setFurnitures:(NSArray<FurnitureModel *> *)furnitures{
    _furnitures = furnitures;
    if (furnitures.count != 0) {
         [self reloadData];
    }
}

#pragma mark <UICollectionViewDelegate>
/**
 *  点击item的触发事件
 *
 *  @param collectionView collectionView
 *  @param indexPath      indexPath
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.TY_delegate respondsToSelector:
                 @selector(TY_collectionView:
                    didSelectItemAtIndexPath:)]) {
         [self.TY_delegate TY_collectionView:collectionView
                    didSelectItemAtIndexPath:indexPath];
    }
}

/**
 *  返回自己的高度
 *
 *  @return 高度值
 */
- (CGFloat)height{
    return ((_itemCount / 2) + (_itemCount % 2)) * ItemH + (((_itemCount / 2) + (_itemCount % 2)) * JPMargin);
}

+ (CGFloat)height{
    return ((10 / 2) + (10 % 2)) * ItemH + (((10 / 2) + (10 % 2)) * JPMargin);
}

@end
