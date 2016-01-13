//
//  FurnitureNetWork.m
//  Unity-iPhone
//
//  Created by tangjp on 16/1/3.
//
//

#import "FurnitureNetWork.h"
#import "Furniture.h"

#define kFurnitureIdPath @"http://www.skyhives.com/goodsapi?goodsId="

@implementation FurnitureNetWork
+ (id)getFurnituresWithFurnitureId:(NSInteger)ID block:(void (^)(id, NSError *))completionHandle{
    NSDictionary *params = [NSDictionary dictionary];
    NSString *path = [NSString stringWithFormat:@"%@%ld",kFurnitureIdPath,ID];
    
    return [self GET:path parameters:params completionHandler:^(id responseObj, NSError *error) {
#warning LOG...
        NSLog(@"responseObj==%@",responseObj);
        
        completionHandle([Furniture mj_objectWithKeyValues:responseObj],error);
    }];
}
@end
