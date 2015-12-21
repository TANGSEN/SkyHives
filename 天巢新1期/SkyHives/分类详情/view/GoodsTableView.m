//
//  GoodsTableView.m
//  天巢新1期
//
//  Created by tangjp on 15/12/14.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "GoodsTableView.h"

#define kROWH 435.0f

CGFloat cellH;

@implementation GoodsTableView
/**
 *  初始化
 *
 *  @param frame 坐标
 *  @param style 风格样式
 *
 *  @return 当前对象
 */
-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self                              = [super initWithFrame:frame
                                                       style:style];
    self.delegate                     = self;
    self.dataSource                   = self;
    self.showsVerticalScrollIndicator = YES;
    self.bounces                      = NO;
//    self.rowHeight                    = kROWH;
    self.separatorStyle               = UITableViewCellSeparatorStyleNone;
    
    return self;
    
}

/**
 *  每个分区有多少行
 *
 *  @param tableView tableview
 *  @param section   section
 *
 *  @return 行数
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.cellCount;
}

/**
 *  每一行显示的样子
 *
 *  @param tableView tableview
 *  @param indexPath indexPath
 *
 *  @return 描述好的cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier   = @"cell";
    UITableViewCell *cell         = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell                      == nil) {
        cell                      = [[UITableViewCell alloc]
                                     initWithStyle:UITableViewCellStyleSubtitle
                                     reuseIdentifier:Identifier];
    }
    // 商品效果图
    UIImageView *imageView        = [[UIImageView alloc]init];
    imageView.frame               = CGRectMake(5, 0, JPScreenW - 10, 200 - 5);
    //    imageView.image               = [UIImage imageNamed:self.images[indexPath.row]];
    imageView.image           = [UIImage imageNamed:@"placehyolder"];
    imageView.backgroundColor = RandomColor;
    
    // 商品细节图1
    UIImageView *xj1ImageView      = [[UIImageView alloc]init];
    xj1ImageView.frame             = CGRectMake(imageView.x, CGRectGetMaxY(imageView.frame) + 5, (JPScreenW - 10) / 2, 150);
    xj1ImageView.backgroundColor = RandomColor;
    xj1ImageView.image             = [UIImage imageNamed:@"placehyolder"];
    
    // 商品细节图1
    UIImageView *xj2ImageView      = [[UIImageView alloc]init];
    xj2ImageView.frame             = CGRectMake(CGRectGetMaxX(xj1ImageView.frame), CGRectGetMaxY(imageView.frame) + 5, (JPScreenW - 10) / 2, 150);
    xj2ImageView.backgroundColor = RandomColor;
    xj2ImageView.image             = [UIImage imageNamed:@"placehyolder"];
    
    // 商品标题
    UILabel *titleLabel           = [[UILabel alloc]init];
    titleLabel.text               = @"拉菲格慕 梦幻紫色圆梦大床";
    titleLabel.textColor          = Color(155, 151, 157);
    CGSize titleSize              = [titleLabel.text sizeWithFont:
                                     [UIFont boldSystemFontOfSize:15]];
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.frame              = (CGRect){{imageView.x,CGRectGetMaxY(xj1ImageView.frame)+5},titleSize};
    
    // 分类标题
    UILabel *describeLabel        = [[UILabel alloc]init];
    describeLabel.text            = @"一道爱情的幸运符,喷上它变身年轻活力的少女,清晰,愉悦!";
    describeLabel.textColor       = Color(155, 151, 157);
    CGSize describeSize           = [describeLabel.text sizeWithFont:
                                     [UIFont boldSystemFontOfSize:12]];
    describeLabel.font = [UIFont boldSystemFontOfSize:12];
    describeLabel.frame              = (CGRect){{imageView.x,CGRectGetMaxY(titleLabel.frame)+5},describeSize};
    
    // 低价标题
    UILabel *priceLabel           = [[UILabel alloc]init];
    priceLabel.text               = @"￥9999";
    priceLabel.textColor          = Color(255, 65, 67);
    CGSize priceSize              = [priceLabel.text sizeWithFont:
                                     [UIFont boldSystemFontOfSize:15]];
    priceLabel.font = [UIFont boldSystemFontOfSize:15];
    priceLabel.frame              = (CGRect){{imageView.x,CGRectGetMaxY(describeLabel.frame)+5},priceSize};
    
    [cell.contentView              addSubview:xj1ImageView];
    [cell.contentView              addSubview:xj2ImageView];
    [cell.contentView              addSubview:imageView];
    
    [cell.contentView              addSubview:titleLabel];
    [cell.contentView              addSubview:describeLabel];
    [cell.contentView              addSubview:priceLabel];
    return cell;
}

/**
 *  点击每一行触发事件
 *
 *  @param tableView tableview
 *  @param indexPath indexPath
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.TYGoods_delegate respondsToSelector:@selector(TYGoods_tableView:didSelectRowAtIndexPath:)]) {
        [self.TYGoods_delegate TYGoods_tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

/**
 *  返回分区头部视图的高度
 *
 *  @param tableView tableview
 *  @param section   section
 *
 *  @return 分区头部视图高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
    
}

/**
 *  返回分区头部视图的标题
 *
 *  @param tableView tableview
 *  @param section   section
 *
 *  @return 分区头部视图标题
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return nil;
}

/**
 *  返回每一行的高度
 *
 *  @param tableView tableview
 *  @param indexPath indexPath
 *
 *  @return 行高
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"-----------%f",cellH);
    return kROWH;
}


- (CGFloat)height{
    
    return kROWH * self.cellCount;
}

@end
