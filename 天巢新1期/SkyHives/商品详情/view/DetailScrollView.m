//
//  DeteilScrollView.m
//  天巢网
//
//  Created by tangjp on 15/11/17.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "DetailScrollView.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@interface DetailScrollView ()
@end


static NSMutableArray *_photos;
@implementation DetailScrollView

+ (DetailScrollView *)scrollViewWithImages:(NSArray *)images {
    DetailScrollView *scrollView = [[self alloc]init];
    _photos = [[NSMutableArray alloc]init];
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
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:scrollView action:@selector(tap:)];
        [imageView addGestureRecognizer:tap];
        [_photos addObject:imageName];
    }
    scrollView.contentSize = CGSizeMake(count * imageW, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = Color(246, 246, 246);
    return scrollView;
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    UIView *tapView = tap.view;
    // Photo -> MJPhoto
    int i = 0;
    NSMutableArray *arrM = [NSMutableArray array];
    // 为了使用MJPhotoBrowser , 需要将Photo -> MJPhoto
    for (NSString *photo in _photos) {
        
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

@end
