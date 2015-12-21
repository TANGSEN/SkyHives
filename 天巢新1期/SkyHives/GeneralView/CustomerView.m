//
//  CustomerView.m


#import "CustomerView.h"
#import "NSString+Extension.h"

@interface CustomerView ()
/**标签数量*/
@property (nonatomic,strong)NSArray *subjects;
/**字体大小*/
@property (nonatomic,assign)NSInteger font;

@end

@implementation CustomerView




- (id)initWithFrame:(CGRect)frame  initButWithArray:(NSArray*)subjects butFont:(NSInteger)font
{
    self=[super initWithFrame:frame];
    
    if(self)
    {
        self.btnArray = [NSMutableArray arrayWithCapacity:0];

        self.backgroundColor=[UIColor whiteColor];
        
        CGRect rct=self.frame;
        
        float width=rct.size.width;
        self.subjects = [[NSArray alloc] init];
        self.subjects = subjects;
        float cel=ceilf(width/[subjects count]);
        
        
        
        CGSize titleSize = [(NSString *)[subjects objectAtIndex:0] sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(MAXFLOAT, 45)];
        float titleW = titleSize.width;
        
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:self.font];
        
        /**采用新的方法 第一次横线会不出现*/
        
//        CGSize titleSize = [[subjects objectAtIndex:0] boundingRectWithSize:CGSizeMake(MAXFLOAT, 45) options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttrs context:nil].size;
//        
//        float titleW = titleSize.width;

        self.font = font;
        
        lineView = [[UIImageView alloc]initWithFrame:CGRectMake((cel-titleW)/2, rct.size.height-2, titleW, 2)];
        
        lineView.backgroundColor = Color(245, 58, 64);
        [lineView setUserInteractionEnabled:YES];
        self.currentIndex = 1;
        for (int i=0; i<[subjects count]; i++) {
            
            UIButton *butTitle = [UIButton buttonWithType:0];
       
            butTitle.tag=i+1;
            butTitle.titleLabel.textAlignment = NSTextAlignmentCenter;
            [butTitle setTitle:[subjects objectAtIndex:i] forState:UIControlStateNormal];
            
            [butTitle setTitle:[subjects objectAtIndex:i] forState:UIControlStateSelected];
            
            
            [butTitle setTitleColor:Color_Common forState:UIControlStateNormal];
            [butTitle setTitleColor:Color(245, 58, 64) forState:UIControlStateSelected];
            
            [self.btnArray addObject:butTitle];
            
            //设置第一个为默认的
            if (self.currentIndex == butTitle.tag) {
                butTitle.selected = YES;
                
            }else{
                
                butTitle.selected = NO;
            }
            
            butTitle.titleLabel.font =[UIFont boldSystemFontOfSize:font];

            [butTitle setFrame:CGRectMake(i*cel, 0, cel, rct.size.height-2)];

            
            [butTitle addTarget:self action:@selector(Onclick:) forControlEvents:UIControlEventTouchUpInside];
            butTitle.userInteractionEnabled = YES;
            [self addSubview:butTitle];
            
            
        }
        [self addSubview:lineView];
        
        [self setUserInteractionEnabled:YES];
    }
    return self;
}



- (void)Onclick:(UIButton *)but
{
    but.selected = YES;
    
    for (UIButton *button in self.btnArray) {
        if (![button isEqual:but]) {
            [button setSelected:NO];
            
        }
    }
    
    NSInteger SelectTag=but.tag;

//    CGSize titleSize = [but.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:self.font] constrainedToSize:CGSizeMake(MAXFLOAT, 45)];
//    float titleW = titleSize.width;
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:self.font];
    
    CGSize titleSize = [but.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 45) options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttrs context:nil].size;
    
    float titleW = titleSize.width;
    
    
    CGRect rct=self.frame;
    
    float width=rct.size.width;
    
    float cel=ceilf(width/self.subjects.count);
    
    if([self.delegate conformsToProtocol:@protocol(CustomerDelegate)])
    {
        [self.delegate OnclickCustomerTag:SelectTag];
        
        [UIView animateWithDuration:0.1 animations:^{
            
            [lineView setFrame:CGRectMake(but.frame.origin.x+(cel-titleW)/2,but.frame.size.height, titleW, 2)];
     
        } completion:^(BOOL finished){
            
            self.currentIndex = but.tag;

            
            
        }];
    
    }
    
}

@end



