//
//  FurnituresNetWork.h
//  Unity-iPhone
//
//  Created by tangjp on 15/12/29.
//
//

#import "JPNetWork.h"
#import "FurnitureModel.h"

typedef NS_ENUM(NSUInteger, FurnitureType) {
    FurnitureTypeSofa = 0,        // 沙发
    FurnitureTypeTea,        // 茶几
    
    FurnitureTypeBed,          // 床
    FurnitureTypeChildren,         // 儿童床
    FurnitureTypeCabinet,        // 柜
    FurnitureTypeDecoration,        // 饰品
    FurnitureTypeFoodie,         // 餐桌
    FurnitureTypeChair,          // 椅子
    
    
};

@interface FurnituresNetWork : JPNetWork
+ (id)getFurnituresWithFurnitureType:(FurnitureType)type block:kCompletionHandle;
+ (id)getSeeAgainWithFurnitureType:(FurnitureType)type block:kCompletionHandle;
@end
