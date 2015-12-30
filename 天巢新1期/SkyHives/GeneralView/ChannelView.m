//
//  ChannelView.m
//  天巢网
//
//  Created by tangjp on 15/11/13.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "ChannelView.h"
/**  列数 */
//#define JPBtnMaxCols 4
/**  行数 */
//#define JPBtnMaxRows 2
/** 间距 */
#define JPChannelMargin 10
/** 自身的高度 */
#define SelfH 180;

//#define JPBtnCount 8

@interface ChannelView ()

@property (nonatomic ,strong) UIButton *btn;
@property (nonatomic ,strong) UILabel *label;

@property (nonatomic ,strong) UIView *channel;

@end


@implementation ChannelView

- (void)setChannelImagesAndNames:(NSArray *)channelImagesAndNames{
    _channelImagesAndNames = channelImagesAndNames;
    NSArray *images = channelImagesAndNames[0];
    NSArray *names = channelImagesAndNames[1];
    for (int i = 0; i < self.cols * self.rows; i++) {
        UIView *channel = [[UIView alloc]init];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, JPScreenW / 4, 40)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(btn.x, CGRectGetMaxY(btn.frame), btn.width, 20)];
        btn.userInteractionEnabled =NO;
        label.userInteractionEnabled = NO;
        self.label = label;
        self.btn = btn;
        label.font = [UIFont boldSystemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        [channel addSubview:btn];
        [channel addSubview:label];
        channel.userInteractionEnabled = YES;
        label.textColor = Color(128, 128, 128);
        [self addSubview:channel];
        channel.tag = i;
        self.channel = channel;
        [self.btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        self.label.text = names[i];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnMargin = 0;
    CGFloat btnW = (self.width - 4 * btnMargin) / self.cols;
    CGFloat btnH = (self.height - JPChannelMargin) / self.rows;
    NSInteger count = self.cols * self.rows;
    
    for (int i = 0; i < count; i++) {
        // 行号
        int row = i / self.cols;
        // 列号
        int col = i % self.cols;
        UIView *channel = self.subviews[i];
            channel.x = col * (btnMargin + btnW) + btnMargin / 2;
            channel.y = row * btnH + 5;
            channel.width = btnW;
            channel.height = btnH;
    }
}

+ (CGFloat)height{
    return SelfH;
}

@end
