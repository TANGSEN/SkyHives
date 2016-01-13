//
//  FurnitureModel.m
//  Unity-iPhone
//
//  Created by tangjp on 15/12/29.
//
//

#import "FurnitureModel.h"

@implementation FurnitureModel


- (void)setThumb:(NSString *)thumb{
    
    thumb = [thumb stringByReplacingOccurrencesOfString:@"Picture" withString:@"Thumb_Picture"];
    _thumb = thumb;
}




@end




