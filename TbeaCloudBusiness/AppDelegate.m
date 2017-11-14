//
//  AppDelegate.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/16.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "AppDelegate.h"
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize diliweizhi;
@synthesize userinfo;

-(void)configUSharePlatforms
{
	[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
	//设置用户自定义的平台
	/* 设置微信的appKey和appSecret */
	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx40e15e8bcce18854" appSecret:@"0269aebaa2a77888d93fbb353776f342" redirectURL:@"http://mobile.umeng.com/social"];
	
	/* 设置分享到QQ互联的appID
	 * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
	 */
	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1101463256"  appSecret:@"ujIK1wAbhkZofcUs" redirectURL:@"http://mobile.umeng.com/social"];
	
	/* 设置新浪的appKey和appSecret */
	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"26170847"  appSecret:@"b81c5595707412ccd395aaf922d4bc3e" redirectURL:@"http://sns.whalecloud.com"];
}

-(void)initJPush:(NSDictionary *)launchOptions
{
	JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
	entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
	if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
		
	}
	[JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
	[JPUSHService setupWithOption:launchOptions appKey:appKey
						  channel:channel
				 apsForProduction:isProduction
			advertisingIdentifier:nil];
	
	[JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
		if(resCode == 0){
			NSLog(@"registrationID获取成功：%@",registrationID);
//			[self updatajpushregiestid:registrationID];
		}
		else{
			NSLog(@"registrationID获取失败，code：%d",resCode);
		}
	}];
	[[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

-(void)initdiliweizhi
{
	diliweizhi = [[DiliWeiZhi alloc] init];
	diliweizhi.dilicity = @"德阳市";
	diliweizhi.diliprovince = @"四川省";
	diliweizhi.latitude = 31.143560;
	diliweizhi.longitude = 104.408080;
	
	//31.143560, 104.408080
	
	NSFileManager *filemanger = [NSFileManager defaultManager];
	userinfo = [[UserInfo alloc] init];
	if([filemanger fileExistsAtPath:UserMessage])
	{
		NSDictionary *userdic = [NSDictionary dictionaryWithContentsOfFile:UserMessage];
		DLog(@"userdic====%@",userdic);
		userinfo.userid = [userdic objectForKey:@"id"];
		userinfo.username =   [userdic objectForKey:@"name"];
		userinfo.userheader =  [userdic objectForKey:@"picture"];
		userinfo.usertel =  [userdic objectForKey:@"mobile"];
		userinfo.userpermission = [userdic objectForKey:@"whetheridentifiedid"];
		userinfo.usertype = [userdic objectForKey:@"usertypeid"];
        userinfo.useraccount = [userdic objectForKey:@"account"];
	}
    
}

-(void)initGmachineid
{
    self.GBURLPreFix = @"";
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSString *machdic = [userDefaults stringForKey:@"machid"];
	if([machdic length]>0)
	{
		self.GBmachid = machdic;
	}
	else
	{
		NSString *machid = [[UIDevice currentDevice] uniqueDeviceIdentifier];
		self.GBmachid = machid;
		[userDefaults setObject:machid forKey:@"machid"];
		[userDefaults synchronize];
		
	}
	
	
	if(self.GBmachid!=nil)
	{
		
	}
	else
	{
		NSString *machid = [[UIDevice currentDevice] uniqueDeviceIdentifier];
		self.GBmachid = machid;
		[userDefaults setObject:machid forKey:@"machid"];
		[userDefaults synchronize];
	}
	DLog(@"self.Gmachid=======================%@",self.GBmachid);
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	//初始化machineid
	[self initGmachineid];
	
	//初始化地理位置
	[self initdiliweizhi];
	
	//极光IM JMessage
	//	[self initJMessage:launchOptions];
	//极光推送
	[self initJPush:launchOptions];
	//友盟分享
	/* 设置友盟appkey */
	[[UMSocialManager defaultManager] setUmSocialAppkey:TYUMKey];
	[self configUSharePlatforms];
	
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	
	[self.window makeKeyAndVisible];
	
	
	HomePageViewController *vc1 = [[HomePageViewController alloc] init];
	vc1.tabBarItem.image = LOADIMAGE(@"bt首页", @"png");
	vc1.title = @"首页";
	vc1.tabBarItem.selectedImage = LOADIMAGE(@"bt首页1", @"png");
	
	TbeaPageViewController *vc2 = [[TbeaPageViewController alloc] init];
	vc2.title = @"特变电工";
	vc2.tabBarItem.image = LOADIMAGE(@"bt特变电工", @"png");
	vc2.tabBarItem.selectedImage = LOADIMAGE(@"bt特变电工1", @"png");
	
	OtherAppPageViewController *vc3 = [[OtherAppPageViewController alloc] init];
	vc3.title = @"其它应用";
	vc3.tabBarItem.image = LOADIMAGE(@"bt其它应用", @"png");
	vc3.tabBarItem.selectedImage = LOADIMAGE(@"bt其它应用1", @"png");
	
	MyPageViewController *vc4 = [[MyPageViewController alloc] init];
	vc4.title = @"我的";
	vc4.tabBarItem.image = LOADIMAGE(@"bt我的", @"png");
	vc4.tabBarItem.selectedImage = LOADIMAGE(@"bt我的1", @"png");
	
	
	UINavigationController *navC1 = [[UINavigationController alloc] initWithRootViewController:vc1];
	UINavigationController *navC2 = [[UINavigationController alloc] initWithRootViewController:vc2];
	UINavigationController *navC3 = [[UINavigationController alloc] initWithRootViewController:vc3];
	UINavigationController *navC4 = [[UINavigationController alloc] initWithRootViewController:vc4];
	
	/**************************************** Key Code ****************************************/
	UITabBarController *tabBarC    = [[UITabBarController alloc] init];
	//    tabBarC.itemTitleFont          = [UIFont boldSystemFontOfSize:11.0f];
	//    tabBarC.itemTitleColor         = [UIColor greenColor];
	//    tabBarC.selectedItemTitleColor = [UIColor redColor];
	//    tabBarC.itemImageRatio         = 0.5f;
	//    tabBarC.badgeTitleFont         = [UIFont boldSystemFontOfSize:12.0f];
    tabBarC.tabBar.tintColor = COLORNOW(0, 170, 238);
	tabBarC.viewControllers        = @[navC1, navC2, navC3, navC4];
	self.window.rootViewController = tabBarC;
	[[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark 推送处理
#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
	// Required
	NSDictionary * userInfo = notification.request.content.userInfo;
	DLog(@"cccccc===%@",userInfo);
	if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
		[JPUSHService handleRemoteNotification:userInfo];
	}
	completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support  //程序 在后台的时候调用此函数
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler
{
	// Required
	NSDictionary * userInfo = response.notification.request.content.userInfo;
	DLog(@"bbbbbbbb===%@",userInfo);
	if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
	{
		[JPUSHService handleRemoteNotification:userInfo];
	}
	completionHandler();  // 系统要求执行这个方法

	//推送新闻处理
//	[self getjpushinfo:[userInfo objectForKey:@"cw_id"] cwtype:[userInfo objectForKey:@"cw_type"]];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
	[JPUSHService handleRemoteNotification:userInfo];
	DLog(@"saaaaaa===%@",userInfo);
	completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
	[JPUSHService handleRemoteNotification:userInfo];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > 100000
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
	//6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响。
	BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
	if (!result) {
		// 其他如支付等SDK的回调
	}
	return result;
}

#endif

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
	//6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
	BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
	if (!result) {
		// 其他如支付等SDK的回调
	}
	return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
	BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
	if (!result) {
		// 其他如支付等SDK的回调
	}
	return result;
}

@end
