//
//  WaterMettingListViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/4.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/*
 0201-总经销商-水电工会议-列表
 */

#import <UIKit/UIKit.h>

@interface WaterMettingListViewController : UIViewController<AndyDropDownDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	
    EnWaterMettingSelectItem enselectitem;
    
    //数据
    NSArray *FCarraydata;
    
    //状态列表
    NSArray *FCarraystatus;
    
    //参数
    NSString *FCmettingcode;
    NSString *FCzoneid;
    NSString *FCmeetingstatusid;
    NSString *FCmeetingstarttime;
    NSString *FCmeetingendttime;
    NSString *FCorderitem;
    NSString *FCorderid;
	
	AndyDropDownList *andydroplist;
	NSMutableArray *arrayselectitem;
	int flagnow; //表明当前的是否显示
	
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
