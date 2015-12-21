//
//  UIWindow+Extension.m
//  微博
//
//  Created by This is GeGe iMac on 15/6/29.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "UIWindow+Extension.h"

@implementation UIWindow (Extension)

- (void)switchRootViewController
{
    NSString *key = @"CFBundleVersion";
    // 上一次使用的版本 (存储在沙盒中的版本号)
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    // 当前软件的版本号 (从 Info.plist中获得)
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        // 版本号相同: 这次打开和上次是同一个版本
//        self.rootViewController = [[TabbarViewController alloc] init];
    }else { // 这次打开的版本和上一次不一样, 显示新特性
//        self.rootViewController = [[JPNewFeatureViewController alloc] init];
        // 将当前的版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)switchRootViewControllerTo:(UIViewController *)viewController
{
    self.rootViewController = viewController;
}

@end
