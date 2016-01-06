//
//  Fruniture.h
//  Unity-iPhone
//
//  Created by tangjp on 16/1/3.
//
//

#import <Foundation/Foundation.h>

/**  http://www.skyhives.com/goodsapi?goodsId=198
 {"spec":"单人位：长1000mm*宽1010mm*高1110mm双人位：长1610mm*宽1010mm*高1110mm 三人位：长2200mm*宽1010mm*高1110mm","imgs":"[\"\\http:\/\/img.k980.com\/Uploads\\\/Picture\\\/2015-11-04\\\/o_1a38ljetf81o1ruf15mb1cm7nuia.jpg\",\"\\http:\/\/img.k980.com\/Uploads\\\/Picture\\\/2015-11-04\\\/o_1a38ljinhmg81o8kd8f10jg1kkrc.jpg\"]","sku":[],"brand_name":null,"content":"<p><img src=\"http:\/\/img.k980.com\/Uploads\/Picture\/2015-11-04\/5639b1f341016.jpg\" style=\"\"\/><\/p><p><img src=\"http:\/\/img.k980.com\/Uploads\/Picture\/2015-11-04\/5639b1fd0eeee.jpg\" style=\"\"\/><\/p><p style=\"text-align: center;\"><br\/><\/p>","price":30600.0,"market_price":61200.0,"color":null,"description":null,"name":"美式古典实木纯手工雕刻真皮沙发","sold_count":0,"style_name":"古典","place":"广东"}
 */

@interface Furniture : NSObject

/** 商品描述 */
@property (nonatomic, copy) NSString *descrip;

/** 商品名称 */
@property (nonatomic, copy) NSString *name;

/** 产地 */
@property (nonatomic, copy) NSString *place;

/** 品牌 */
@property (nonatomic, copy) NSString *brand_name;

/** 属性 */
@property (nonatomic, strong) NSArray *sku;

/** 商品颜色 */
@property (nonatomic, copy) NSString *color;

/** 现价 */
@property (nonatomic, assign) NSInteger price;

/** 原价 */
@property (nonatomic, assign) NSInteger market_price;

/** 尺寸规格 */
@property (nonatomic, copy) NSString *spec;

/** 风格 */
@property (nonatomic, copy) NSString *style_name;

/** 销量 */
@property (nonatomic, assign) NSInteger sold_count;

/** 图片数组 */
@property (nonatomic, copy) NSString *imgs;

/** 内容 */
@property (nonatomic, copy) NSString *content;

@end
