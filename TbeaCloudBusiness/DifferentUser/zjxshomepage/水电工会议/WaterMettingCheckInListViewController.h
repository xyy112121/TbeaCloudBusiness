//
//  WaterMettingCheckInListViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/7.
//  Copyright © 2017年 谢 毅. All rights reserved.
//
/**
 0401-01-总经销商-水电工会议-水电工签到列表
 **/

#import <UIKit/UIKit.h>

@interface WaterMettingCheckInListViewController : UIViewController<AndyDropDownDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	
	EnWaterMettingCheckInListSelectItem enselectitem;
	
	AndyDropDownList *andydroplist;
	NSMutableArray *arrayselectitem;
	int flagnow; //表明当前的是否显示
	
    //
    NSArray *FCarrayusertype;
    NSArray *FCarraydata;
    //
    NSString *FCname;
    NSString *FCownertypeid;
    NSString *FCstarttime;
    NSString *FCendtime;
    NSString *FCorderitem;
    NSString *FCorderid;
    
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
