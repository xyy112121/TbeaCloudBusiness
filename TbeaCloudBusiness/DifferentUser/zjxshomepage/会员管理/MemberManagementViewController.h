//
//  MemberManagementViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/22.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0101-01-01-管理员-会员列表
 **/

#import <UIKit/UIKit.h>

@interface MemberManagementViewController : UIViewController<AndyDropDownDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource,YBPopupMenuDelegate>
{
	UITableView *tableview;
	AppDelegate *app;

	EnMemberMangerSelectItem enselectitem;
	
	AndyDropDownList *andydroplist;
	NSArray *arrayselectitem;
	int flagnow; //表明当前的是否显示
	
	YBPopupMenu *ybpopmenu;
}


@end
