//
//  TCShoppingViewController.m
//  skyhives
//
//  Created by tangjp on 15/12/8.
//
//

#import "TCShoppingViewController.h"

@interface TCShoppingViewController ()
@end


static NSMutableArray *_modelArray = nil;
@implementation TCShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _modelArray = [[NSMutableArray alloc]init];
}

+ (void)addModel:(int)model{
    if (model) {
        [_modelArray addObject:@(model)];
    }
}

+ (NSArray *)getAllModel{
    return [_modelArray copy];
}

@end
