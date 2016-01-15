//
//  ShoppingModel.h
//  天巢网
//
//  Created by 赵贺 on 15/11/30.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingModel : NSObject


@property (nonatomic ,assign) NSInteger goodsId;
@property (nonatomic ,assign) NSInteger id;

@property (nonatomic ,assign) NSInteger item_count;
@property (nonatomic ,assign) NSInteger price;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *thumb;


//@property (nonatomic,copy)NSString *ProductName;
//@property (nonatomic,copy)NSString *Count;
//@property (nonatomic,copy)NSString *Price;
@property (nonatomic ,assign,getter = isSelected) BOOL Selected;
//+(NSMutableArray *)demoData;
+(ShoppingModel *)shoppingModel;
@end
