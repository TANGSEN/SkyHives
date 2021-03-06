//
//  NSString+Extension.h
//  微博
//
//  Created by This is GeGe iMac on 15/7/3.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

- (CGSize)sizeWithFont:(UIFont *)font;

+ (NSString*)hexStringForData:(NSData*)data;

+ (NSString*)hexStringForChar:(unsigned char *)data len:(int)len;

+ (NSData*)dataForHexString:(NSString*)hexString;

/**
 *  生成随机订单号
 *
 *  @param length 长度
 *
 *  @return 随机订单号
 */
+ (NSString *)rand_str:(int) length ;

@end
