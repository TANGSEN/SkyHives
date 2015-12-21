//
//  UIImage+ColorToBackImage.m
//  天巢新1期
//
//  Created by 赵贺 on 15/12/16.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "UIImage+ColorToBackImage.h"

@implementation UIImage (ColorToBackImage)
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
  
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
   
    UIGraphicsBeginImageContext(rect.size);
   
    CGContextRef context = UIGraphicsGetCurrentContext();
   
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
   
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
   
    UIGraphicsEndImageContext();
    
    return image;
    
}

@end
