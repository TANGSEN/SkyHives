//
//  NewAddressController.h
//  天巢新1期
//
//  Created by 赵贺 on 16/1/7.
//  Copyright © 2016年 tangjp. All rights reserved.
//新增地址

#import <UIKit/UIKit.h>

@interface NewAddressController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)NSString *orderName;
@property(nonatomic,copy)NSString *orderPhone;
@property(nonatomic,copy)NSString *orderStreet;


@end
