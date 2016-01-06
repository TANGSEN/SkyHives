//
//  GGCSView.h
//  天巢网
//
//  Created by tangjp on 15/11/17.
//  Copyright © 2015年 tangjp. All rights reserved.
//  规格参数

#import <UIKit/UIKit.h>
#import "Furniture.h"

@interface GGCSView : UITableView
+ (CGFloat)Height;
@property (nonatomic ,strong) Furniture *furniture;
@end
