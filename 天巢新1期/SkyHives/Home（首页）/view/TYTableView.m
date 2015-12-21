//
//  TYTableView.m
//  Unity-iPhone
//
//  Created by tangjp on 15/12/9.
//
//

#import "TYTableView.h"


#define kROWH 150.0f

@interface TYTableView ()

@property (nonatomic ,strong) UILabel *label;

@end

@implementation TYTableView 
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
    self.rowHeight                    = kROWH;
    self.separatorStyle               = UITableViewCellSeparatorStyleNone;
    self.backgroundColor              = [UIColor whiteColor];
    
    
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
    cell.backgroundColor          = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle =UITableViewCellSelectionStyleNone ;
    // 商品图片占满整个cell
    UIImageView *imageView        = [[UIImageView alloc]init];
    imageView.frame               = CGRectMake(5, 0, JPScreenW - 10, kROWH - 5);
    imageView.image               = [UIImage imageNamed:self.images[indexPath.row]];
    
    // 上线钜惠标签图片
    UIImageView *sxImageView      = [[UIImageView alloc]init];
    sxImageView.frame             = CGRectMake(0, 0, 35, 35);
    sxImageView.image             = [UIImage imageNamed:@"icon_sxjh"];
    
    // 分类标题
    UILabel *titleLabel           = [[UILabel alloc]init];
    titleLabel.text               = @"煲剧专用";
    titleLabel.textColor          = Color(155, 151, 157);
    CGSize titleSize              = [titleLabel.text sizeWithFont:
                                     [UIFont boldSystemFontOfSize:20]];
    titleLabel.frame              = (CGRect){{150,20},titleSize};
    
    // 低价标题
    UILabel *priceLabel           = [[UILabel alloc]init];
    priceLabel.text               = @"全场 599 起";
    priceLabel.textColor          = Color(255, 65, 67);
    priceLabel.font               = [UIFont boldSystemFontOfSize:20];
    CGSize priceSize              = [priceLabel.text sizeWithFont:
                                     [UIFont boldSystemFontOfSize:25]];
    priceLabel.frame              = (CGRect){{150,CGRectGetMaxY(titleLabel.frame)+5},priceSize};
    
    // 时间段标题
    UILabel *dateLabel            = [[UILabel alloc]init];
    dateLabel.text                = @"活动时间:12/12-1/12";
    dateLabel.textColor           = Color(155, 151, 157);
    CGSize dateSize               = [dateLabel.text sizeWithFont:
                                    [UIFont boldSystemFontOfSize:20]];
    dateLabel.frame               = (CGRect){{150,CGRectGetMaxY(priceLabel.frame)+5},dateSize};
    
    // 入场疯抢标签
    UILabel *startLabel           = [[UILabel alloc]init];
    startLabel.text               = @"入场疯抢";
    startLabel.textColor          = [UIColor whiteColor];
    
    startLabel.textAlignment      = NSTextAlignmentCenter;
    CGSize startSize              = [startLabel.text sizeWithFont:
                                     [UIFont boldSystemFontOfSize:20]];
    startLabel.backgroundColor    = Color(232, 84, 79);
    startLabel.frame              = (CGRect){{150,CGRectGetMaxY(dateLabel.frame)+5},startSize};
    startLabel.layer.cornerRadius = 5.0f;
    startLabel.layer.borderColor  = RandomColor.CGColor;
    startLabel.layer.borderWidth  = 3.0f;
    startLabel.clipsToBounds      = YES;
    //
//    [imageView                    addSubview:sxImageView];
//    [imageView                    addSubview:titleLabel];
//    [imageView                    addSubview:priceLabel];
//    [imageView                    addSubview:dateLabel];
//    [imageView                    addSubview:startLabel];
    [cell.contentView             addSubview:imageView];
    
    return cell;
}

/**
 *  点击每一行触发事件
 *
 *  @param tableView tableview
 *  @param indexPath indexPath
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.TY_delegate respondsToSelector:@selector(TY_tableView:didSelectRowAtIndexPath:)]) {
        [self.TY_delegate TY_tableView:tableView didSelectRowAtIndexPath:indexPath];
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
    return kROWH;
}


- (CGFloat)height{
    return kROWH * self.cellCount;
}

@end
