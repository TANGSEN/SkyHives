//
//  NSData+AESEncryption.h
//  天巢新1期
//
//  Created by tangjp on 16/1/11.
//  Copyright © 2016年 tangjp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AESEncryption)

- (NSData *)AES256EncryptWithKey:(NSString *)key;   //加密

- (NSData *)AES256DecryptWithKey:(NSString *)key;   //解密

- (NSString *)newStringInBase64FromData;            //追加64编码

+ (NSString*)base64encode:(NSString*)str;           //同上64编码


- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv;
- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv;
- (NSString *)base64Encoding;
+ (id)dataWithBase64EncodedString:(NSString *)string;

@end
