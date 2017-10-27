//
//  WaterLoginViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0701-水电工个人页面-管理权限-管理-登录统计
 **/

#import <UIKit/UIKit.h>

@interface WaterLoginViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	

	
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;
@end
