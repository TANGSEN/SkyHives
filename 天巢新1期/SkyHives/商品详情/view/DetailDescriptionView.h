//
//  DetailDescriptionView.h
//  天巢网
//
//  Created by tangjp on 15/11/17.
//  Copyright © 2015年 tangjp. All rights reserved.
//  商品描述包括价格\销量\介绍

#import <UIKit/UIKit.h>

@interface DetailDescriptionView : UIView
+ (DetailDescriptionView *)descriptionView;
+ (CGFloat)height;
/** 价格 */
@property (nonatomic ,assign) NSInteger price;
/** 销量 */
@property (nonatomic ,assign) NSInteger sales;
/**商品标题*/
@property (nonatomic ,copy) NSString *name;
@end
