//
//  AppDelegate.m
//  天巢新1期
//
//  Created by tangjp on 15/12/11.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "AppDelegate.h"
#import "TCTabBarController.h"
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    TCTabBarController *tabbarVc = [[TCTabBarController alloc]init];
    self.window.rootViewController = tabbarVc;
    
    /**社会化分享*/
    [ShareSDK registerApp:ShareAppKey];
    //
    //    //1.添加微信应用
    [ShareSDK connectWeChatWithAppId:WXAppID
                           appSecret:WXAppSecret
                           wechatCls:[WXApi class]];
    //
    //    //2.微信朋友圈
    [ShareSDK connectWeChatTimelineWithAppId:WXAppID appSecret:WXAppSecret wechatCls:[WXApi class]];
    //
    //    //3.QQ
    [ShareSDK connectQQWithAppId:QQAppID qqApiCls:[QQApiInterface class]];
    
    //    [SMSSDK registerApp:SMSAppKey withSecret:SMSAppSecret];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
    return canHandleURL;
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary *)options {
    BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
    return canHandleURL;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
