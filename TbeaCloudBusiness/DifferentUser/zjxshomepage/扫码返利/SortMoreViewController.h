//
//  SortMoreViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/26.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0403-扫码返利-提现排名
 **/

#import <UIKit/UIKit.h>

@interface SortMoreViewController : UIViewController<AndyDropDownDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	
	EnSortMoreSelectItem enselectitem;
	EnScanRebateHpUserType enusertype;//当前选择的用户类型
	
	AndyDropDownList *andydroplist;
	NSMutableArray *arrayselectitem;
	int flagnow; //表明当前的是否显示
	
	//
	NSArray *FCarraydata;
	
	//
	NSString *FCorderid;
	NSString *FCorderitem;
	NSString *FCstarttime;
	NSString *FCendtime;
	NSString *FCzonelds;
	
	
}
@property(nonatomic,strong)NSString *FCfdistributorid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
