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
#define addAddressUrl @"http://www.skyhives.com/m/user/editadd"

@interface NewAddressController ()<UITextFieldDelegate>

@property (nonatomic,strong)NSArray *titles;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UITextField *textField0;
@property (nonatomic,strong)UITextField *textField1;
@property (nonatomic,strong)UITextField *textField3;

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
    
    BOOL isMatched = [Utils checkTelNumber:self.textField1.text];
    
    if (!isMatched) {
        [self showErrorMsg:@"请输入正确的手机号码"];
        return;
    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"name"] = self.textField0.text;
    params[@"area"] = _cityPickerView.showMsg;
    params[@"tel"] = self.textField1.text;
    params[@"street"] = self.textField3.text;
    
    
    [JPNetWork GET:addAddressUrl parameters:params completionHandler:^(id responseObj, NSError *error) {
        if (!error) {
            [self showSuccessMsg:responseObj[@"msg"]];
            NSLog(@"addAddError===%@",error);
        }
        else
        {
            NSLog(@"addAddError===%@",error);
            
        }
    }];
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
        self.textField0 = [[UITextField alloc] initWithFrame:CGRectMake(120, 0, JPScreenW-135, 44)];
        self.textField0.clearButtonMode = UITextFieldViewModeAlways;
        self.textField0.delegate = self;
        self.textField0.font = AppFont(14);
        self.textField0.keyboardType = UIKeyboardTypeDefault;
        [cell.contentView addSubview:self.textField0];
        
    }
    else if (indexPath.row == 1){
        self.textField1 = [[UITextField alloc] initWithFrame:CGRectMake(120, 0, JPScreenW-135, 44)];
        self.textField1.font = AppFont(14);
        self.textField1.clearButtonMode = UITextFieldViewModeAlways;
        self.textField1.delegate = self;
        self.textField1.keyboardType = UIKeyboardTypeNumberPad;
        [cell.contentView addSubview:self.textField1];
        
        
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
        self.textField3 = [[UITextField alloc] initWithFrame:CGRectMake(120, 0, JPScreenW-135, 44)];
        self.textField3.clearButtonMode = UITextFieldViewModeAlways;
        self.textField3.delegate = self;
        self.textField3.keyboardType = UIKeyboardTypeDefault;
        self.textField3.font = AppFont(14);
        
        [cell.contentView addSubview:self.textField3];
        
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
        [self.textField0 resignFirstResponder];
        [self.textField1 resignFirstResponder];
        [self.textField3 resignFirstResponder];
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
    [self.textField0 resignFirstResponder];
    [self.textField1 resignFirstResponder];
    [self.textField3 resignFirstResponder];

    _cityPickerView = [[CityPickerView alloc] initWithFrame:CGRectMake(0, JPScreenH - 200, JPScreenW, 200)];
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
