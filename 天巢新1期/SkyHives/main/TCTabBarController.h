//
//  TCTabBarController.h
//  天巢网
//
//  Created by tangjp on 15/11/10.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "Singleton.h"

@interface TCTabBarController : UITabBarController
//singleton_h(TabBarController)
@property (nonatomic ,assign) NSInteger lastSelectedIndex;
@end
