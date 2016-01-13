//
//  AdvertisementModel.m
//  天巢网
//
//  Created by tangjp on 15/11/26.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "AdvertisementModel.h"

@implementation AdvertisementModel

- (void)setThumb:(NSString *)thumb{
    
    thumb = [thumb stringByReplacingOccurrencesOfString:@"Picture" withString:@"Thumb_Picture"];
    _thumb = thumb;
}

@end




