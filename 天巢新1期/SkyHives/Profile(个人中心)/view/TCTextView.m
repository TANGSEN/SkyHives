//
//  TRTextView.m
//  微博
//
//  Created by 赵贺 on 15/7/13.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "TCTextView.h"
@interface TCTextView()<UITextViewDelegate>

@property(weak,nonatomic) UILabel *placeholderLabel;


@end
@implementation TCTextView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *placeholderLabel = [[UILabel alloc] init];
        [self addSubview:placeholderLabel];
        
        
        self.layer.borderWidth = 0.4f;
        self.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
        self.placeholderLabel = placeholderLabel;
        self.delegate = self;
/**键盘上添加“完成”按钮*/
        [self keyboardDisappearce];
        self.font = AppFont(text_size_little_2);
        self.placeholderLabel.textColor = [UIColor lightGrayColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
        
        
    }
    return self;
    
}

#pragma mark - textView delegate


#warning 如需换行可视情况取消
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
    
}

#pragma mark - private
-(void)keyboardDisappearce{
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, ApplicationframeValue.width, 44)];
    topView.backgroundColor = [UIColor whiteColor];
    
    [topView setBarStyle:UIBarStyleDefault];
    
    [topView setTranslucent:YES];
    
    //定义两个flexibleSpace的button，放在toolBar上，这样完成按钮就会在最右边
    
    UIBarButtonItem * button1 =[[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem* button2 = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    //定义完成按钮
    UIBarButtonItem
    * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成"style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard)];

    
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = AppColor;
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    
    
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    
    //在toolBar上加上这些按钮
    NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
    
    [topView setItems:buttonsArray];
    
    [self setInputAccessoryView:topView];
    
}

-(void)resignKeyboard
{
    
    [self resignFirstResponder];
    
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
    self.placeholderLabel.y = 8;
    self.placeholderLabel.x = 8;
    self.placeholderLabel.width = self.width - 2*self.placeholderLabel.x;
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[NSFontAttributeName] = self.font;
    CGSize titleSize = [self.placeholder sizeWithAttributes:params];
    self.placeholderLabel.height = titleSize.height;
    
    
}


@end
