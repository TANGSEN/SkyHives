//
//  CityPickerView.m
//  天巢新1期
//
//  Created by 赵贺 on 1/7/16.
//  Copyright © 2016 tangjp. All rights reserved.
//

#import "CityPickerView.h"

@interface CityPickerView ()
@property (nonatomic,strong)UIPickerView *pickView;
@end


@implementation CityPickerView

-(NSString *)showMsg
{
    NSInteger provinceIndex = [self.pickView selectedRowInComponent: 0];
    NSInteger cityIndex = [self.pickView selectedRowInComponent: 1];
    NSInteger districtIndex = [self.pickView selectedRowInComponent: 2];
    NSString *provinceStr = [self.provinces objectAtIndex: provinceIndex];
    NSString *cityStr = [self.citys objectAtIndex: cityIndex];
    NSString *districtStr = [self.districts objectAtIndex:districtIndex];
    
    if ([provinceStr isEqualToString: cityStr] || [cityStr isEqualToString: districtStr]) {
        cityStr = @"";
    }
    else if ([cityStr isEqualToString: districtStr]) {
        districtStr = @"";
    }
    
    NSString * showMsg = [NSString stringWithFormat: @"%@%@%@", provinceStr, cityStr, districtStr];
    return showMsg;
    
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self getAreaData];

        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:AppColor forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = AppFont(13);
        
        _DoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(JPScreenW-50, 0, 40, 40)];
        [_DoneBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_DoneBtn setTitleColor:AppColor forState:UIControlStateNormal];
        _DoneBtn.titleLabel.font = AppFont(13);
        [self addSubview:_cancelBtn];
        [self addSubview:_DoneBtn];
        
        self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, JPScreenW, self.height - _cancelBtn.height)];
        
        self.pickView.delegate = self;
        self.pickView.dataSource = self;
        self.pickView.showsSelectionIndicator = YES;
        [self.pickView selectRow:0 inComponent:0 animated:YES];
        _selectedProvince = [_provinces objectAtIndex: 0];

        [self addSubview:self.pickView];
        
    }
    return self;
    
}

#pragma mark - private

-(void)getAreaData{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
    _areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSArray *components = [_areaDic allKeys];
    
    /**对城市按序号进行排序*/
    
    NSArray *sortedArray = [components sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSMutableArray *provinceTmp = [[NSMutableArray alloc] init];
    for (int i = 0; i<[sortedArray count]; i++) {
        NSString *index = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[_areaDic objectForKey:index] allKeys];
        [provinceTmp addObject:[tmp objectAtIndex:0]];
    }
    _provinces = [[NSArray alloc] initWithArray:provinceTmp];
    
    NSString *index = [sortedArray objectAtIndex:0];
    NSString *selected = [_provinces objectAtIndex:0];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[_areaDic objectForKey:index]objectForKey:selected]];
    
    NSArray *cityArray = [dic allKeys];
    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:0]]];
    _citys = [[NSArray alloc] initWithArray: [cityDic allKeys]];
    
    
    NSString *selectedCity = [_citys objectAtIndex: 0];
    _districts = [[NSArray alloc] initWithArray: [cityDic objectForKey: selectedCity]];
    
    
    
}
#pragma mark - pickerview datasource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        
        return [_provinces count];
    }
    else if (component == 1) {
        
        return _citys.count;
        
    }
    else {
        
        return _districts.count;
    }
    
    
    
}
#pragma mark - pickerview delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        _selectedProvince = [_provinces objectAtIndex: row];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [_areaDic objectForKey: [NSString stringWithFormat:@"%ld", (long)row]]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: _selectedProvince]];
        NSArray *cityArray = [dic allKeys];
        NSArray *sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;//递减
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;//上升
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i=0; i<[sortedArray count]; i++) {
            NSString *index = [sortedArray objectAtIndex:i];
            NSArray *temp = [[dic objectForKey: index] allKeys];
            [array addObject: [temp objectAtIndex:0]];
        }
        
        _citys = [[NSArray alloc] initWithArray: array];
        
        NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex: 0]];
        _districts = [[NSArray alloc] initWithArray: [cityDic objectForKey: [_citys objectAtIndex: 0]]];
        [_pickView selectRow: 0 inComponent: CITY_COMPONENT animated: YES];
        [_pickView selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        [_pickView reloadComponent: CITY_COMPONENT];
        [_pickView reloadComponent: DISTRICT_COMPONENT];
        
    }
    else if (component == CITY_COMPONENT) {

        NSString *provinceIndex = [NSString stringWithFormat: @"%lu", (unsigned long)[_provinces indexOfObject: _selectedProvince]];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [_areaDic objectForKey: provinceIndex]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: _selectedProvince]];
        NSArray *dicKeyArray = [dic allKeys];
        NSArray *sortedArray = [dicKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [sortedArray objectAtIndex: row]]];
        NSArray *cityKeyArray = [cityDic allKeys];
        
        _districts = [[NSArray alloc] initWithArray: [cityDic objectForKey: [cityKeyArray objectAtIndex:0]]];
        [_pickView selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        [_pickView reloadComponent: DISTRICT_COMPONENT];
    }
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return JPScreenW/3;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = nil;
    
    if (component == PROVINCE_COMPONENT) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, JPScreenW/3, 30)];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [_provinces objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    else if (component == CITY_COMPONENT) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, JPScreenW/3, 30)];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [_citys objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    else {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, JPScreenW/3, 30)];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [_districts objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    
    return myView;
}




@end
