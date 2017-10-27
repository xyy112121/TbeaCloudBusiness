//
//  MemberMangementSelectUserTypeViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/23.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0101-02-02-管理员-会员列表-用户类型筛选-选择
 **/

#import <UIKit/UIKit.h>

@interface MemberMangementSelectUserTypeViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	
	NSMutableArray *arrayselect;
}


@end
