//
//  DetailDescriptionView.m
//  天巢网
//
//  Created by tangjp on 15/11/17.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "DetailDescriptionView.h"
@interface DetailDescriptionView ()
@property (nonatomic ,strong) UILabel *nameLabel;
@property (nonatomic ,strong) UIButton *btn;
@property (nonatomic ,weak) UILabel *priceLabel;
@property (nonatomic ,strong) UILabel *salesLabel;
@end

/** 私有变量 视图自身的高度值 */
static CGFloat _height;

@implementation DetailDescriptionView

/**
 *  类方法创建一个视图
 *
 *  @return 创建好的视图
 */
+ (DetailDescriptionView *)descriptionView{
    DetailDescriptionView *descriptionView = [[self alloc]init];
    // 添加所有子控件
    [descriptionView addSubControl];
    
    return descriptionView;
    
}

- (instancetype)init{
    if (self = [super init]) {
        // 添加所有子控件
        [self addSubControl];
    }
    return self;
}

- (void)setPrice:(NSInteger)price{
    _price = price;
    NSString *str = [NSString stringWithFormat:@"￥%ld",(long)price];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, str.length)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
    self.priceLabel.attributedText = string;
}

- (void)setSales:(NSInteger)sales{
    _sales = sales;
    NSString *salesStr = [NSString stringWithFormat:@"已售%ld",(long)sales];
    self.salesLabel.text = salesStr;
}

- (void)setName:(NSString *)name{
    _name = name;
    self.nameLabel.text = [@"  " stringByAppendingString:name];
}

/**
 *  添加所有子控件
 */
- (void )addSubControl{
    // 商品标题
    UILabel *nameLabel  = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, JPScreenW - 60, 40)];
    [self addSubview:nameLabel];
    nameLabel.font = [UIFont boldSystemFontOfSize:12];
    nameLabel.textColor = [UIColor grayColor];
    nameLabel.numberOfLines = 2;
    self.nameLabel = nameLabel;
    
    // 商品标题和分享按钮之间的分割线
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame) + 10, 10, 0.5, 25)];
    label.backgroundColor = [UIColor grayColor];
    label.alpha = 0.7;
    [self addSubview:label];
    
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
    [self addSubview:btn];
    self.btn = btn;
    [btn bk_addEventHandler:^(id sender) {
        ShareView *view = [[ShareView alloc] initWithFrame:CGRectMake(0, ApplicationframeValue.height - 160, ApplicationframeValue.width, 160)];
        view.content = @"天巢网";
        view.message = @"快来挑选一下属于你的家具吧";
        view.shareUrl = @"https://www.skyhives.com/";
//        view.pictureName = @"76-76";
        [view show];
    } forControlEvents:UIControlEventTouchUpInside];
    
    // 价格标签是一个有属性的字符串
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(nameLabel.frame), JPScreenW / 2, 40)];
//    NSInteger price = rand() % 10000;
    
    self.priceLabel = priceLabel;
    [self addSubview:priceLabel];
    
    // 销量标签 sales
    UILabel *salesLabel = [[UILabel alloc]initWithFrame:CGRectMake(JPScreenW / 2, priceLabel.y, JPScreenW / 2 - 15, priceLabel.height)];
    salesLabel.textColor = [UIColor grayColor];
    salesLabel.textAlignment = NSTextAlignmentRight;
    salesLabel.font = [UIFont boldSystemFontOfSize:10];
    self.salesLabel = salesLabel;
    [self addSubview:salesLabel];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(priceLabel.frame) + 10, JPScreenW - 20, 0.5)];
    label2.backgroundColor = [UIColor grayColor];
    label2.alpha = 0.7;
    [self addSubview:label2];
    
    // 优惠标签 preferential
    UILabel *preferentialLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, label2.y + 10, JPScreenW, 40)];
    preferentialLabel.numberOfLines = 0;
    NSString *preferentialStr = @"全国包邮\n上门安装";
    preferentialLabel.text = preferentialStr;
    preferentialLabel.textColor = [UIColor orangeColor];
    preferentialLabel.font = [UIFont boldSystemFontOfSize:12];
    [self addSubview:preferentialLabel];
    _height = CGRectGetMaxY(preferentialLabel.frame);
}

- (void)click{
    NSLog(@"hahahahhah");
}

/**
 *  返回视图自身的高度
 *
 *  @return 高度值
 */
+ (CGFloat)height{
    return _height;
}

@end
