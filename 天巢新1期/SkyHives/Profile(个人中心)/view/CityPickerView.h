//
//  CityPickerView.h
//  天巢新1期
//
//  Created by 赵贺 on 1/7/16.
//  Copyright © 2016 tangjp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
/**区域字典*/
@property (nonatomic,strong)NSDictionary *areaDic;
/**省*/
@property (nonatomic,strong)NSArray *provinces;
/**市区*/
@property (nonatomic,strong)NSArray *citys;
/**县区*/
@property (nonatomic,strong)NSArray *districts;
/**选中的第一component*/
@property (nonatomic,copy)  NSString *selectedProvince;
/**最终城市*/
@property (nonatomic,copy)NSString *showMsg;
/**取消按钮*/
@property (nonatomic,strong)UIButton *cancelBtn;
/**确定按钮*/
@property (nonatomic,strong)UIButton *DoneBtn;
@end
