//
//  UIImage+Extension.h
//  黑马微博
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 *  根据图片名自动加载适配iOS6\7的图片
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  根据图片名返回一张能够自由拉伸的图片
 */
+ (UIImage *)resizedImage:(NSString *)name;

/**
 *  返回一张裁剪好的带边线颜色的图片
 *
 *  @param name        要裁减的图片名
 *  @param borderWidth 边线的宽
 *  @param borderColor 边线的颜色
 *
 *  @return 裁剪好的图片
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;


/**返回圆形图片*/
+(instancetype)roundImageWith:(UIImage *)image;
@end
