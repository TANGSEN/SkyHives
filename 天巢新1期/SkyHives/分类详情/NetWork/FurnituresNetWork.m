//
//  FurnituresNetWork.m
//  Unity-iPhone
//
//  Created by tangjp on 15/12/29.
//  http://www.skyhives.com/categoryapi/sofa
//  http://www.skyhives.com/frontapi/category?seeagain=sofa

#import "FurnituresNetWork.h"

#define kFurniturePath @"http://www.skyhives.com/categoryapi/"
#define kSeeAgainPath @"http://www.skyhives.com/frontapi/category?seeagain="

@implementation FurnituresNetWork

+ (id)getFurnituresWithFurnitureType:(FurnitureType)type block:(void (^)(id, NSError *))completionHandle{
    NSDictionary *params = [NSDictionary dictionary];
    NSString *path = @"";
    switch (type) {
        case FurnitureTypeSofa:
            path = [kFurniturePath stringByAppendingString:@"sofa"];
            break;
        
        case FurnitureTypeChair:
            path = [kFurniturePath stringByAppendingString:@"desk"];
            break;
        
        case FurnitureTypeFoodie:
            path = [kFurniturePath stringByAppendingString:@"foodie"];
            break;
        
        case FurnitureTypeChildren:
            path = [kFurniturePath stringByAppendingString:@"children"];
            break;
        
        case FurnitureTypeTea:
            path = [kFurniturePath stringByAppendingString:@"tea"];
            break;
        
        case FurnitureTypeBed:
            path = [kFurniturePath stringByAppendingString:@"bed"];
            break;
        
        case FurnitureTypeCabinet:
            path = [kFurniturePath stringByAppendingString:@"cabinet"];
            break;
        
        case FurnitureTypeDecoration:
            path = [kFurniturePath stringByAppendingString:@"decoration"];
            break;
            
        default:
            break;
    }
    
    return [self GET:path parameters:params completionHandler:^(id responseObj, NSError *error) {
        completionHandle([FurnitureModel mj_objectArrayWithKeyValuesArray:responseObj],error);
    }];
}

+ (id)getSeeAgainWithFurnitureType:(FurnitureType)type block:(void (^)(id, NSError *))completionHandle{
    NSDictionary *params = [NSDictionary dictionary];
    NSString *path = @"";
    switch (type) {
        case FurnitureTypeSofa:
            path = [kFurniturePath stringByAppendingString:@"sofa"];
            break;
            
        case FurnitureTypeChair:
            path = [kFurniturePath stringByAppendingString:@"desk"];
            break;
            
        case FurnitureTypeFoodie:
            path = [kFurniturePath stringByAppendingString:@"foodie"];
            break;
            
        case FurnitureTypeChildren:
            path = [kFurniturePath stringByAppendingString:@"children"];
            break;
            
        case FurnitureTypeTea:
            path = [kFurniturePath stringByAppendingString:@"tea"];
            break;
            
        case FurnitureTypeBed:
            path = [kFurniturePath stringByAppendingString:@"bed"];
            break;
            
        case FurnitureTypeCabinet:
            path = [kFurniturePath stringByAppendingString:@"cabinet"];
            break;
            
        case FurnitureTypeDecoration:
            path = [kFurniturePath stringByAppendingString:@"decoration"];
            break;
            
        default:
            break;
    }
    
    return [self GET:path parameters:params completionHandler:^(id responseObj, NSError *error) {
        completionHandle([FurnitureModel mj_objectArrayWithKeyValuesArray:responseObj],error);
    }];
}


@end
