//
//  SharedInstance.h
//  天巢网
//
//  Created by 赵贺 on 15/11/27.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedInstance : NSObject
+(SharedInstance *)sharedInstance;

/**设置密码*/
-(void)setPassword:(NSString *)password;
/**获取密码*/
-(NSString *)getPassword;

/**设置用户名*/
-(void)setUserName:(NSString *)userName;
/**获取用户名*/
-(NSString *)getUserName;

/**设置用户账号*/
-(void)setPhoneNumber:(NSString *)phoneNumber;
/**获取用户账号*/
-(NSString *)getPhoneNumber;

/**设置用户头像*/
-(void)setUserImage:(UIImage *)image;
/**获取用户头像*/
-(UIImage *)getUserImage;


/**清楚所有信息*/
-(void)clearAllData;


/**标记用户是否已经登陆*/
@property (nonatomic,assign)  BOOL alreadyLanded;

/**设置USERID*/
-(void)setUserID:(NSString *)UserID;

/**获取userID*/
-(NSString *)getUserID;


@end
