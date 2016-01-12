//
//  NewAddressController.m
//  天巢新1期
//
//  Created by 赵贺 on 16/1/7.
//  Copyright © 2016年 tangjp. All rights reserved.
//

#import "NewAddressController.h"

#import "CityPickerView.h"
#import "Utils.h"
#import "OrderAddressModel.h"
#define addAddressUrl @"http://www.skyhives.com/m/user/editadd"

@interface NewAddressController ()<UITextFieldDelegate>

@property (nonatomic,strong)NSArray *titles;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UITextField *name;
@property (nonatomic,strong)UITextField *PhoneNum;
@property (nonatomic,strong)UITextField *Street;

/**城市选择器视图*/
@property (nonatomic,strong)CityPickerView *cityPickerView;
/**省市区--行*/
@property (nonatomic,strong)UIButton *CitySelectedBtn;
@end

@implementation NewAddressController

-(NSArray *)titles
{
    if (!_titles) {
        _titles =[NSArray arrayWithObjects:@"*收货人",@"*手机号码",@"*省市区",@"*详细地址",nil] ;
    }
    return _titles;
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = View_BgColor;
    
    self.title = @"新增地址";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(Done)];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, JPScreenW, JPScreenH - self.cityPickerView.height)];
    self.tableView.backgroundColor = View_BgColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = FooterView;
    [self.view addSubview:self.tableView];
    
}
#warning 保存
/**保存数据*/
-(void)Done{
    
    BOOL isMatched = [Utils checkTelNumber:self.PhoneNum.text];
    
    if (!isMatched) {
        [self showErrorMsg:@"请输入正确的手机号码"];
        return;
    }
    
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"name"] = self.name.text;
    params[@"area"] = _cityPickerView.showMsg;
    params[@"tel"] = self.PhoneNum.text;
    params[@"street"] = self.Street.text;
    params[@"zp-browse-id"] = [[SharedInstance sharedInstance]getUserID];

    
    
    
    [JPNetWork GET:addAddressUrl parameters:params completionHandler:^(id responseObj, NSError *error) {
        if (!error) {
            [self showSuccessMsg:responseObj[@"msg"]];
            
            NSLog(@"addAddError===%@",error);
        }
        else
        {
            [self showErrorMsg:responseObj[@"msg"]];
            NSLog(@"addAddError===%@",error);
            
        }
    }];
    
    
    
//    [self.navigationController popViewControllerAnimated:YES];
    
}



#pragma mark - tableView datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    
    if (indexPath.row == 0){
        self.name = [[UITextField alloc] initWithFrame:CGRectMake(120, 0, JPScreenW-135, 44)];
        self.name.clearButtonMode = UITextFieldViewModeAlways;
        self.name.delegate = self;
        self.name.font = AppFont(14);
        self.name.keyboardType = UIKeyboardTypeDefault;
        [cell.contentView addSubview:self.name];
        
    }
    else if (indexPath.row == 1){
        self.PhoneNum = [[UITextField alloc] initWithFrame:CGRectMake(120, 0, JPScreenW-135, 44)];
        self.PhoneNum.font = AppFont(14);
        self.PhoneNum.clearButtonMode = UITextFieldViewModeAlways;
        self.PhoneNum.delegate = self;
        self.PhoneNum.keyboardType = UIKeyboardTypeNumberPad;
        [cell.contentView addSubview:self.PhoneNum];
        
        
    }else  if (indexPath.row ==2) {
        
        UIButton *CitySelectedBtn = [[UIButton alloc] initWithFrame:CGRectMake(120, 0, JPScreenW-120, 44)];
        [CitySelectedBtn addTarget:self action:@selector(addPickerView) forControlEvents:UIControlEventTouchUpInside];
        //            [CitySelectedBtn setTitle:self.showMsg forState:UIControlStateNormal];
        [CitySelectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        CitySelectedBtn.titleLabel.font = AppFont(14);
        CitySelectedBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [CitySelectedBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        self.CitySelectedBtn = CitySelectedBtn;
        [cell.contentView addSubview:CitySelectedBtn];
        
    }
    else {
        self.Street = [[UITextField alloc] initWithFrame:CGRectMake(120, 0, JPScreenW-135, 44)];
        self.Street.clearButtonMode = UITextFieldViewModeAlways;
        self.Street.delegate = self;
        self.Street.keyboardType = UIKeyboardTypeDefault;
        self.Street.font = AppFont(14);
        
        [cell.contentView addSubview:self.Street];
        
    }
    
    
    cell.textLabel.text = self.titles[indexPath.row];
    cell.textLabel.font = AppFont(14);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
    
}

#pragma mark - table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_cityPickerView removeFromSuperview];
    if (indexPath.row == 2) {
        [self.name resignFirstResponder];
        [self.PhoneNum resignFirstResponder];
        [self.Street resignFirstResponder];
        [self addPickerView];
    }
    
    
}

#pragma mark - textfield delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [_cityPickerView removeFromSuperview];
    [textField becomeFirstResponder];
    
}


#pragma mark - private
-(void)addPickerView
{
    
    
    [_cityPickerView removeFromSuperview];
    [self.name resignFirstResponder];
    [self.PhoneNum resignFirstResponder];
    [self.Street resignFirstResponder];

    _cityPickerView = [[CityPickerView alloc] initWithFrame:CGRectMake(0, JPScreenH - 240, JPScreenW, 240)];
    [self.view addSubview:_cityPickerView];

    
    
    /**取消按钮*/
    [_cityPickerView.cancelBtn bk_addEventHandler:^(id sender) {
        [UIView animateWithDuration:0.35f animations:^{
            [_cityPickerView removeFromSuperview];

        }];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
    /**确定按钮*/
    [_cityPickerView.DoneBtn bk_addEventHandler:^(id sender) {
        [UIView animateWithDuration:0.35f animations:^{
            [_cityPickerView removeFromSuperview];
            
        }];
        [self.CitySelectedBtn setTitle:_cityPickerView.showMsg forState:UIControlStateNormal];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
}
@end
