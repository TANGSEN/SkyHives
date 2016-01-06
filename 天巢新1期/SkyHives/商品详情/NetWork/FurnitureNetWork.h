//
//  FurnitureNetWork.h
//  Unity-iPhone
//
//  Created by tangjp on 16/1/3.
//
//

#import <Foundation/Foundation.h>

@interface FurnitureNetWork : JPNetWork
+ (id)getFurnituresWithFurnitureId:(NSInteger)ID block:kCompletionHandle;
@end
