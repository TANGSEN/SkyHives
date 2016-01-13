//
//  OrderAddressModel.h
//  天巢新1期
//
//  Created by 赵贺 on 16/1/12.
//  Copyright © 2016年 tangjp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderAddressModel : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *detailed_address;
@property (nonatomic,copy)NSString *phone;

+(NSMutableArray *)demoData;
+(OrderAddressModel *)orderAddressModel;
+(id)OrderAddressWithDict:(NSDictionary *)dict;
@end
