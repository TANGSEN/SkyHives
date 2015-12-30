//
//  AttributeCollectionView.m
//  天巢新1期
//
//  Created by tangjp on 15/12/15.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "AttributeView.h"


@interface AttributeView ()

@property (nonatomic ,weak) UIButton *btn;
@end

@implementation AttributeView

/**
 *  返回一个创建好的属性视图,并且带有标题.创建好之后必须设置视图的Y值.
 *
 *  @param texts 属性数组
 *
 *  @return attributeView
 */
+ (AttributeView *)attributeViewWithTitle:(NSString *)title titleFont:(UIFont *)font attributeTexts:(NSArray *)texts{
    int count = 0;
    float btnW = 0;
    AttributeView *view = [[AttributeView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]init];
    label.text = [NSString stringWithFormat:@"%@ : ",title];
    label.font = font;
    label.textColor = Color(160, 160, 160);
    CGSize size = [label.text sizeWithFont:font];
    label.frame = (CGRect){{10,10},size};
    [view addSubview:label];
    for (int i = 0; i<texts.count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        [btn addTarget:view action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        NSString *str = texts[i];
        [btn setTitle:str forState:UIControlStateNormal];
        CGSize strsize = [str sizeWithFont:[UIFont boldSystemFontOfSize:13]];
        if (i == 0 ) {
            btn.x = 5;
            btnW += strsize.width;
        }else{
            btnW += strsize.width + 25;
            if (btnW >= JPScreenW) {
                count++;
                btn.x = 5;
                btnW = strsize.width;
            }else{
                
                btn.x += btnW - strsize.width;
            }
            
        }
        btn.backgroundColor = Color(236, 236, 236);
        [btn setAlpha:0.5];
        btn.userInteractionEnabled = YES;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.y += count * (strsize.height + 10) + 15 + label.height;
        btn.width = strsize.width + 10;
        btn.height = strsize.height;
        btn.layer.cornerRadius = 6.0f;

        btn.clipsToBounds = YES;
        btn.tag = i;
        [view addSubview:btn];
        if (i == texts.count - 1) {
            view.height = CGRectGetMaxY(btn.frame) + 10;
            view.x = 0;
            view.width = JPScreenW;
        }
    }
    return view;
}

- (void)btnClick:(UIButton *)sender{
    if (![self.btn isEqual:sender]) {
//        self.btn.backgroundColor = Color(236, 236, 236);
        [self.btn setAlpha:0.5];
        self.btn.layer.borderWidth = 0.0f;
        self.btn.layer.borderColor = Color(250, 86, 87).CGColor;
    }
        [sender setAlpha:0.6];
        sender.layer.borderWidth = 1.0f;
        sender.layer.borderColor = Color(250, 86, 87).CGColor;
    self.btn = sender;
}

@end
