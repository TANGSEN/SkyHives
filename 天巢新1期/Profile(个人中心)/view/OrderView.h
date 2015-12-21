//
//  OrderView.h
//  天巢新1期
//
//  Created by 赵贺 on 15/12/19.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderView : UIView
/**订单图片*/
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
/**产品名字*/
@property (weak, nonatomic) IBOutlet UILabel *OrderProductName;
/**产品简介*/
@property (weak, nonatomic) IBOutlet UILabel *OrderDetail;
/**产品数量*/
@property (weak, nonatomic) IBOutlet UILabel *OrderCount;
/**产品价格*/
@property (weak, nonatomic) IBOutlet UILabel *OrderPrice;
/**立即购买*/
@property (weak, nonatomic) IBOutlet UIButton *BuyNow;

@end
