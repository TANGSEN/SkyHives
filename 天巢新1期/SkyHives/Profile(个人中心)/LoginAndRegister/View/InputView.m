//
//  InputView.m
//  天巢新1期
//
//  Created by 赵贺 on 15/12/17.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "InputView.h"

@implementation InputView

-(void)initWithImagesArr:(NSArray *)imagesArr placeHolders:(NSArray *)placeHolders

{
    



}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *placeholderLabel = [[UILabel alloc] init];
        [self addSubview:placeholderLabel];
        

        
        self.placeholderLabel = placeholderLabel;
        
        self.font = AppFont(text_size_little_2);
        self.placeholderLabel.textColor = [UIColor lightGrayColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
        
        
    }
    return self;
    
}


-(void)textDidChange
{
    
    self.placeholderLabel.hidden = self.text.length;
    
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = placeholder;
    
}
-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = font;
    
    //    重新计算子控件的frame
    [self setNeedsDisplay];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.placeholderLabel.y = 10;
    self.placeholderLabel.x = 8;
    self.placeholderLabel.width = self.width - 2*self.placeholderLabel.x;
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[NSFontAttributeName] = self.font;
    CGSize titleSize = [self.placeholder sizeWithAttributes:params];
    self.placeholderLabel.height = titleSize.height;
    
    
}

@end
