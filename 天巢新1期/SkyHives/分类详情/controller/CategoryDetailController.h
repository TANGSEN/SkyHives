//
//  CategoryDetailController.h
//  天巢新1期
//
//  Created by tangjp on 15/12/12.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FurnituresNetWork.h"

@interface CategoryDetailController : UIViewController
- (instancetype)initWithType:(FurnitureType)type;
@property (nonatomic ,assign) FurnitureType type;
@end
