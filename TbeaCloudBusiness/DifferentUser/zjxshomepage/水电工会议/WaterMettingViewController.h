//
//  WaterMettingViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/3.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0101-总经销商-水电工会议-首页
 **/

#import <UIKit/UIKit.h>

@interface WaterMettingViewController : UIViewController<AndyDropDownDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	
	EnWaterMettingSelectItem enselectitem;
	
    //数据meeting
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
    NSString *FCordermettingcode;
    NSString *FCordermettingtime;
    
	AndyDropDownList *andydroplist;
	NSMutableArray *arrayselectitem;
	int flagnow; //表明当前的是否显示
    
    UIView *viewtopselectitem;  //顶部选项view
    int FCSelectDropListItem;

}

@property(nonatomic,strong)id<ActionDelegate>delegate1;
@end
