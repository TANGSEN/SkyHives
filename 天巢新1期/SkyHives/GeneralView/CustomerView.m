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




- (id)initWithFrame:(CGRect)frame  initButWithArray:(NSArray*)subjects butFont:(NSInteger)font selectedIndex:(NSInteger)selectedIndex
{
    self=[super initWithFrame:frame];
    
    if(self)
    {
        self.btnArray = [NSMutableArray arrayWithCapacity:0];

        self.backgroundColor=[UIColor whiteColor];
        self.currentIndex = selectedIndex;
        CGRect rct=self.frame;
        
        float width=rct.size.width;
        self.subjects = [[NSArray alloc] init];
        self.subjects = subjects;
        float cel=ceilf(width/[subjects count]);
        
        
        NSString *title = subjects.firstObject;
        CGSize titleSize = [title sizeWithFont:[UIFont systemFontOfSize:font]];
        float titleW = titleSize.width;
        
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:self.font];
        
        self.font = font;
        
        lineView = [[UIImageView alloc]initWithFrame:CGRectMake((cel-titleW)/2, rct.size.height-2, titleW, 2)];
        
        lineView.backgroundColor = Color(245, 58, 64);
        [lineView setUserInteractionEnabled:YES];
        for (int i=0; i<[subjects count]; i++) {
            
            UIButton *butTitle = [UIButton buttonWithType:0];
            butTitle.tag = i;
            butTitle.titleLabel.textAlignment = NSTextAlignmentCenter;
            [butTitle setTitle:[subjects objectAtIndex:i] forState:UIControlStateNormal];
            [butTitle setTitle:[subjects objectAtIndex:i] forState:UIControlStateSelected];
            [butTitle setTitleColor:Color_Common forState:UIControlStateNormal];
            [butTitle setTitleColor:Color(245, 58, 64) forState:UIControlStateSelected];
            butTitle.titleLabel.font =[UIFont boldSystemFontOfSize:font];
            [butTitle setFrame:CGRectMake(i*cel, 0, cel, rct.size.height-2)];
            [butTitle addTarget:self action:@selector(Onclick:) forControlEvents:UIControlEventTouchUpInside];
            butTitle.userInteractionEnabled = YES;
            [self addSubview:butTitle];
            [self.btnArray addObject:butTitle];
        }
        [self addSubview:lineView];
        [self Onclick:[self.btnArray objectAtIndex:selectedIndex]];
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
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:self.font];
    CGSize titleSize = [but.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:self.font]];
    
    float titleW = titleSize.width;
    
    
    CGRect rct=self.frame;
    
    float width=rct.size.width;
    
    float cel=ceilf(width/self.subjects.count);
    [UIView animateWithDuration:0.25 animations:^{
        
        [lineView setFrame:CGRectMake(but.frame.origin.x+(cel-titleW)/2,but.frame.size.height, titleW, 2)];
        
    } completion:^(BOOL finished){
        
        self.currentIndex = but.tag;
    }];
    if([self.delegate conformsToProtocol:@protocol(CustomerDelegate)])
    {
        [self.delegate OnclickCustomerTag:SelectTag];
    }
    
}

@end



