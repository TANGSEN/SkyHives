//
//  OrderAddressModel.m
//  天巢新1期
//
//  Created by 赵贺 on 16/1/12.
//  Copyright © 2016年 tangjp. All rights reserved.
//

#import "OrderAddressModel.h"
static OrderAddressModel *order = nil;
@implementation OrderAddressModel

+(OrderAddressModel *)orderAddressModel
{
    @synchronized(self) {
        if (!order) {
            order = [[OrderAddressModel alloc]init];
            return order;
        }
        return order;
    }
    
}
+(NSMutableArray *)demoData
{
    OrderAddressModel *order2 = [[self alloc] init];
    order2.name = @"赵贺";
    order2.phone = @"13324564356";
    order2.detailed_address = @"北京朝阳区";
    
    OrderAddressModel *order1 = [[self alloc] init];
    order1.name = @"苹果";
    order1.phone = @"13687654653";
    order1.detailed_address = @"大连";
    
    OrderAddressModel *order3 = [[self alloc] init];
    order3.name = @"小唐";
    order3.phone = @"13324564356";
    order3.detailed_address = @"广东省广州市天河区";
    return [NSMutableArray arrayWithObjects:order2,order1,order3,nil];
}

+(id)OrderAddressWithDict:(NSDictionary *)dict
{

    OrderAddressModel *order = [[OrderAddressModel alloc] init];
    order.name = dict[@"name"];
    order.phone = dict[@"phone"];
    order.detailed_address = dict[@"detailed_address"];
    
    return order;
}
@end
