//
//  HomeNetWork.m
//  天巢网
//
//  Created by tangjp on 15/11/26.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "HomeNetWork.h"

#define kSeeAgainPath @"http://www.skyhives.com/frontapi/seeagain"

#define kAdvertisementPath @"http://www.skyhives.com/frontapi/rotatePics"

@implementation HomeNetWork

+ (id)getAdcertisementWithBlock:(void (^)(id, NSError *))completionHandle{
    NSDictionary *params = [NSDictionary dictionary];
    return [self GET:kAdvertisementPath parameters:params completionHandler:^(id responseObj, NSError *error) {
        completionHandle([AdvertisementModel mj_objectArrayWithKeyValuesArray:responseObj],error);
    }];
}

+ (id)getSeeAgainFurnitureWithblock:(void (^)(id, NSError *))completionHandle{
    NSDictionary *params = [NSDictionary dictionary];
    
    return [self GET:kSeeAgainPath parameters:params completionHandler:^(id responseObj, NSError *error) {
        completionHandle([FurnitureModel mj_objectArrayWithKeyValuesArray:responseObj],error);
    }];
}

@end
