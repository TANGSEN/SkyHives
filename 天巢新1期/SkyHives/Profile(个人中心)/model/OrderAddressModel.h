//
//  OrderAddressModel.h
//  天巢新1期
//
//  Created by 赵贺 on 16/1/12.
//  Copyright © 2016年 tangjp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderAddressModel : NSObject

@property (nonatomic,copy)NSString *Name;
@property (nonatomic,copy)NSString *Address;
@property (nonatomic,copy)NSString *PhoneNum;

+(NSMutableArray *)demoData;
+(OrderAddressModel *)orderAddressModel;
@end
