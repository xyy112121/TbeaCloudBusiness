//
//  AppDelegate.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/16.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiliWeiZhi.h"
#import "UserInfo.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

static NSString *appKey = @"a9511ac380c5bf1cec9ea50f";  //测试用推送appkey
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;

@interface AppDelegate : UIResponder <UIApplicationDelegate,JPUSHRegisterDelegate>


@property(nonatomic,strong)NSString *GBURLPreFix;
@property(nonatomic,strong)UINavigationController *gnctl;
@property(nonatomic,strong)NSString *pushflag;
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)DiliWeiZhi *diliweizhi;
@property(nonatomic,strong)UserInfo *userinfo;
@property(nonatomic,strong)NSString *GBmachid;  //machid
@property(nonatomic)EnAppUserType enappusertype;
@end

