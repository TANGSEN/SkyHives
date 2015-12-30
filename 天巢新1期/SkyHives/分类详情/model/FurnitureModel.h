//
//  FurnitureModel.h
//  Unity-iPhone
//
//  Created by tangjp on 15/12/29.
//
//

#import <Foundation/Foundation.h>

@interface FurnitureModel : NSObject

@property (nonatomic, copy) NSString *update_time;

@property (nonatomic, copy) NSString *package_num;

@property (nonatomic, copy) NSString *goods_item;

@property (nonatomic, copy) NSString *store_price;

@property (nonatomic, copy) NSString *is_recommend;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *manufacturer_id;

/**
 *  商品图片地址
 */
@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *slogan;

@property (nonatomic, copy) NSString *descrip;

@property (nonatomic, copy) NSString *material;

@property (nonatomic, copy) NSString *is_new;

@property (nonatomic, copy) NSString *brand_id;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *add_time;

@property (nonatomic, copy) NSString *sku_options_ids;

@property (nonatomic, copy) NSString *packages;

@property (nonatomic, copy) NSString *imgs;

@property (nonatomic, copy) NSString *volume;

@property (nonatomic, copy) NSString *brand_name;

@property (nonatomic, copy) NSString *cat_id;

@property (nonatomic, copy) NSString *style_name;

/**
 *  商品名字
 */
@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger sold_count;

@property (nonatomic, copy) NSString *has_collection;

@property (nonatomic, copy) NSString *place;

@property (nonatomic, copy) NSString *status;

/**
 *  商品价格
 */
@property (nonatomic, assign) NSInteger price;

@property (nonatomic, copy) NSString *color;

@property (nonatomic, copy) NSString *sku_ids;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *sku_attr;

/**
 *  商品原价
 */
@property (nonatomic, assign) NSInteger market_price;

@property (nonatomic, copy) NSString *sn;

@property (nonatomic, copy) NSString *spec;

@property (nonatomic, copy) NSString *on_sale;

@property (nonatomic, copy) NSString *stock;

@property (nonatomic, copy) NSString *weight;

@property (nonatomic, copy) NSString *style_id;

@property (nonatomic, copy) NSString *f_class;

@property (nonatomic, copy) NSString *is_item;

@property (nonatomic, copy) NSString *is_hot;

@end



