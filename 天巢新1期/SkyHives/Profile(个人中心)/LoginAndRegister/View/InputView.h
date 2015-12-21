//
//  InputView.h
//  天巢新1期
//
//  Created by 赵贺 on 15/12/17.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputView : UITextView
@property(copy,nonatomic) NSString *placeholder;
@property(weak,nonatomic) UILabel *placeholderLabel;

-(void)initWithImagesArr:(NSArray *)imagesArr placeHolders:(NSArray *)placeHolders;
@end
