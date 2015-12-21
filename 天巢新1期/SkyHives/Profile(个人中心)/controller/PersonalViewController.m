//
//  PersonalViewController.m
//  天巢新1期
//
//  Created by 赵贺 on 15/12/18.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "PersonalViewController.h"
#import "ChangeUserNameController.h"

#import "PhoneBindingController.h"
#import "AddressViewController.h"
#define HeaderViewWidth 100

@interface PersonalViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/**头像*/
@property (nonatomic,strong)UIImageView *headerView;
@property (nonatomic,strong)NSArray *titles;
@property (nonatomic,strong)UITableView *tableView;
/**头像图片*/
@property (nonatomic,strong)UIImage *headerImage;
@end

@implementation PersonalViewController


-(NSArray *)titles
{

    if (!_titles) {
        _titles = @[@"用户名",@"绑定手机号码",@"修改密码",@"我的收货地址"];
    }
    return _titles;

}

-(void)viewWillAppear:(BOOL)animated
{
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"];
    UIImage *image = [NSKeyedUnarchiver unarchiveObjectWithData:imageData];
    self.headerView.image = image;
        
   
    
    
    
//    UIImage *image = [[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"];
//    self.headerView.image = image;
//    CGPoint center = self.headerView.center;
    self.headerView.layer.cornerRadius = HeaderViewWidth/2/2;
    [self.headerView.layer setBorderWidth:0.0f];
    [self.tableView reloadData];

}

-(void)viewDidLoad
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ApplicationframeValue.width, HeaderViewWidth)];
    [self.view addSubview:topView];
//    self.headerView = [[UIImageView alloc] init];
//#warning 修改头像暂时未做
//    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"];
//    if (imageData != nil) {
//        UIImage *image = [NSKeyedUnarchiver unarchiveObjectWithData:imageData];
//        self.headerView.image = image;
//
//    }
    
    self.headerView =[[UIImageView alloc]init];
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"];
    UIImage *image = [NSKeyedUnarchiver unarchiveObjectWithData:imageData];
    self.headerView.image = image;
    
    CGPoint center = self.headerView.center;
    center.x  = topView.bounds.size.width/2-HeaderViewWidth/2/2;
    
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeHeaderView)];
    [topView addGestureRecognizer:tap];
    
    
    center.y  = topView.height/2-30;
    self.headerView.center = center;
    self.headerView.size = CGSizeMake(HeaderViewWidth/2, HeaderViewWidth/2);
    self.headerView.backgroundColor = Color(245, 58, 64);
    self.headerView.layer.cornerRadius = HeaderViewWidth/2/2;
    [self.headerView.layer setBorderWidth:0.0f];
    [topView addSubview:self.headerView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.headerView.origin.x, CGRectGetMaxY(self.headerView.frame), self.headerView.width, 20)];
    
    [topView addSubview:label];
    label.text = @"修改头像";
    label.textColor = [UIColor lightGrayColor];
    label.font = AppFont(12);
    label.textAlignment = NSTextAlignmentCenter;
    
    topView.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3f].CGColor;
    topView.layer.borderWidth = 0.5f;
    

    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 130+64, ApplicationframeValue.width, 200)];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.tableFooterView = FooterView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    self.tableView = tableView;
    [self.view addSubview:tableView];


}



-(void)changeHeaderView{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机" otherButtonTitles:@"相册", nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    [sheet showInView:self.view];
    
}

#pragma mark - ActionSheet Delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [picker setEditing:YES];
    /**调用相机*/
    if (buttonIndex==0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }
        else{
            AlertLog(nil, @"无法调用相机!", @"确定", nil);
        
        }
    }
    /**调用相册*/
    else if(buttonIndex == 1){
    
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    
    }


}
#pragma mark - imagePickerController Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{

    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSData *imageData = [NSKeyedArchiver archivedDataWithRootObject:image];
    [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"headerImage"];
    
    [self dismissViewControllerAnimated:YES completion:^{}];
//    [self.navigationController popViewControllerAnimated:YES];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}



#pragma mark -  tableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell * cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    cell.textLabel.text = self.titles[indexPath.row];
    
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = [[SharedInstance sharedInstance] getUserName];
    }
    if (indexPath.row == 1) {
        cell.detailTextLabel.text = [[SharedInstance sharedInstance] getPhoneNumber];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    UIViewController *obj = nil;
    
    switch (indexPath.row) {
        case 0:
            NSLog(@"点击了%@",self.titles[indexPath.row]);
            
            obj = [[ChangeUserNameController alloc] init];
            break;
        case 1:
            obj = [[PhoneBindingController alloc] init];
            break;
        case 2:
            
            break;
        case 3:
            obj = [[AddressViewController alloc] init];
            break;
            
        default:
            break;
            
            
    }
    
    
    [self.navigationController pushViewController:obj animated:YES];

}


@end



