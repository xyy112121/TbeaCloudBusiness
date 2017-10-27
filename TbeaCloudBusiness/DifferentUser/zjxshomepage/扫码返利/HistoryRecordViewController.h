//
//  HistoryRecordViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/24.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0203-00-返利二维码生成-历史记录
 **/

#import <UIKit/UIKit.h>

@interface HistoryRecordViewController : UIViewController<AndyDropDownDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	
	//下拉弹框
	AndyDropDownList *andydroplist;
	NSMutableArray *arrayselectitem;
	int flagnow; //表明当前的是否显示
	
	EnCreateQRCodeHistorySelectItem enselectitem;
	
	//选择参数
	NSArray *FCarraystatus;
	NSString *FCstarttime;
	NSString *FCendtime;
	NSString *FCstatusid;
	NSString *FCorderitem;
	NSString *FCorderid;
	
	//列表数据
	NSArray *FCarraydata;
	
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
