//
//  SharedInstance.m
//  天巢网
//
//  Created by 赵贺 on 15/11/27.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import "SharedInstance.h"
#import "UIImage+Extension.h"

static SharedInstance *shared = nil;
@implementation SharedInstance
/**单例*/
+(SharedInstance *)sharedInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!shared)
            shared = [[SharedInstance alloc]init];
    });
    
    return shared;
}



/**设置密码*/
-(void)setPassword:(NSString *)password{
    
    [[NSUserDefaults standardUserDefaults]setObject:password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
}
/**获取密码*/
-(NSString *)getPassword{
    
    NSString *apppassword=[[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    return apppassword;
    
}
/**设置用户名*/
-(void)setUserName:(NSString *)userName{
    
    [[NSUserDefaults standardUserDefaults]setObject:userName forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
}
/**获取用户名*/
-(NSString *)getUserName{
    
    
    NSString *username=[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
    
    if ([username isEqualToString:@""]||!username) {
        username = [[SharedInstance sharedInstance] getPhoneNumber];
    }
    
    return username;
    
    
    
}

/**设置用户账号*/
-(void)setPhoneNumber:(NSString *)phoneNumber
{
    [[NSUserDefaults standardUserDefaults]setObject:phoneNumber forKey:@"phoneNumber"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
}
/**获取用户账号*/
-(NSString *)getPhoneNumber
{
    
    NSString *username=[[NSUserDefaults standardUserDefaults]objectForKey:@"phoneNumber"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    return username;
    
}

/**设置用户头像*/
-(void)setUserImage:(UIImage *)image{
    
    
    NSData *imageData = [NSKeyedArchiver archivedDataWithRootObject:image];
    
    [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"headerImage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
/**获取用户头像*/
-(UIImage *)getUserImage{
    
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"];
    if (imageData != nil) {
        UIImage *image = [NSKeyedUnarchiver unarchiveObjectWithData:imageData];
        UIImage *roundImage = [UIImage roundImageWith:image];
        return roundImage;
    }else
        
    {
    
        return [UIImage roundImageWith:nil];
    
    }
    
    
    
}

/**设置userID*/
-(void)setUserID:(NSString *)UserID
{

    [[NSUserDefaults standardUserDefaults] setObject:UserID forKey:@"UserID"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
/**获取userID*/
-(NSString *)getUserID
{
    NSString *UserID=[[NSUserDefaults standardUserDefaults]objectForKey:@"UserID"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    return UserID;
    

}

-(void)clearAllData{
    [SharedInstance sharedInstance].alreadyLanded = NO;
    [[SharedInstance sharedInstance] setPhoneNumber:@""];
    [[SharedInstance sharedInstance] setPassword:@""];
    [[SharedInstance sharedInstance] setUserName:@""];
    [[SharedInstance sharedInstance] setUserImage:nil];
    
}



//-(BOOL)alreadyLanded
//{
//
//    return YES;
//}
@end
