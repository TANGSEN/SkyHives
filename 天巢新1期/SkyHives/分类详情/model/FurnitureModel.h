//
//  FurnitureModel.h
//  Unity-iPhone
//
//  Created by tangjp on 15/12/29.
//
//

#import <Foundation/Foundation.h>

@interface FurnitureModel : NSObject

@property (nonatomic, assign) NSInteger id;

/**
 *  商品图片地址
 */
@property (nonatomic, copy) NSString *thumb;

/**
 *  商品名字
 */
@property (nonatomic, copy) NSString *name;

/** 销量 */
@property (nonatomic, assign) NSInteger sold_count;

/**
 *  商品价格
 */
@property (nonatomic, assign) NSInteger price;


/**
 *  商品原价
 */
@property (nonatomic, assign) NSInteger market_price;


@end



