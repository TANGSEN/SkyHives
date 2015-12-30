//
//  TYCollectionViewCell.m
//  Unity-iPhone
//
//  Created by tangjp on 15/12/10.
//
//

#import "TYCollectionViewCell.h"

@interface TYCollectionViewCell ()
@property (nonatomic ,weak) UIImageView *imageView;
@property (nonatomic ,weak) UIButton *btn;
@property (nonatomic ,weak) UILabel *priceLabel;
@property (nonatomic ,weak) UILabel *salesLabel;

@end

@implementation TYCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self                         = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView       = [[UIImageView alloc]init];
        [self addSubview:imageView];
        imageView.backgroundColor    = RandomColor;
        self.imageView               = imageView;
        
        UIButton *btn                = [[UIButton alloc]init];
        btn.titleLabel.numberOfLines = 2;
        [btn setTitleColor:Color(128, 128, 128)
                  forState:UIControlStateNormal];
        btn.titleLabel.font          = [UIFont systemFontOfSize:12];
        [self addSubview:btn];
        btn.userInteractionEnabled = NO;
        self.btn = btn;
        
        UILabel *priceLabel          = [[UILabel alloc]init];
        priceLabel.textColor         = [UIColor redColor];
        priceLabel.font              = [UIFont boldSystemFontOfSize:12];
        _priceLabel.textAlignment    = NSTextAlignmentCenter;
        [self addSubview:priceLabel];
        self.priceLabel              = priceLabel;
        
        UILabel *salesLabel          = [[UILabel alloc]init];
        salesLabel.textColor         = [UIColor grayColor];
        _salesLabel.textAlignment    = NSTextAlignmentCenter;
        salesLabel.font              = [UIFont boldSystemFontOfSize:12];
        [self addSubview:salesLabel];
        self.salesLabel              = salesLabel;
    }
    return self;
}


- (void)setImageName:(NSString *)imageName{
    _imageName = [imageName copy];
    _imageView.image = [UIImage imageNamed:_imageName];
}

- (void)setTitle:(NSString *)title{
    _title = [title copy];
    [_btn setTitle:_title forState:UIControlStateNormal];
}

- (void)setPrice:(NSInteger)price{
    _price = price;
    _priceLabel.text = [NSString stringWithFormat:@"￥%ld",(long)_price];
    
}

- (void)setSales:(NSInteger)sales{
    _sales = sales;
    _salesLabel.text = [NSString stringWithFormat:@"已售%ld",(long)_sales];
}

- (void)setFurniture:(FurnitureModel *)furniture{
    _furniture = furniture;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.furniture.thumb] placeholderImage:[UIImage imageNamed:@"placehyolder"]];
    [_btn setTitle:self.furniture.name forState:UIControlStateNormal];
    _priceLabel.text = [NSString stringWithFormat:@"￥%ld",(long)self.furniture.price];
    self.sales = rand()%10000;
    _salesLabel.text = [NSString stringWithFormat:@"已售%ld",(long)_sales];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _imageView.frame  = CGRectMake(5, 5, self.width - 10, 150);
    _btn.frame        = CGRectMake(0, CGRectGetMaxY(_imageView.frame) + 5, self.width-5, 40);
    _priceLabel.frame = CGRectMake(0, self.height - 20, self.width / 2, 20);
    _salesLabel.frame = CGRectMake(self.width / 2, self.height - 20, self.width / 2, 20);
    
}
@end
