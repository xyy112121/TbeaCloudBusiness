//
//  WaterLoginDetailViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0702-水电工个人页面-管理权限-管理-登录统计-登录详情
 **/

#import <UIKit/UIKit.h>

@interface WaterLoginDetailViewController : UIViewController<AndyDropDownDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	
	AndyDropDownList *andydroplist;
	NSArray *arrayselectitem;
	int flagnow; //表明当前的是否显示
	
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
