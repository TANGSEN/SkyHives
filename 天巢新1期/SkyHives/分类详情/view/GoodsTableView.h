//
//  GoodsTableView.h
//  天巢新1期
//
//  Created by tangjp on 15/12/14.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FurnitureModel.h"

@protocol TYGoodsTableDelegate<NSObject>
@optional
-(void)TYGoods_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface GoodsTableView : UITableView <UITableViewDataSource , UITableViewDelegate>

@property (nonatomic ,strong) NSArray<FurnitureModel *> *furnitures;
@property(nonatomic,assign)id <TYGoodsTableDelegate>TYGoods_delegate;
@property (nonatomic ,assign) NSInteger cellCount;
@property (nonatomic ,strong) NSArray *images;
- (CGFloat)height;

@end
