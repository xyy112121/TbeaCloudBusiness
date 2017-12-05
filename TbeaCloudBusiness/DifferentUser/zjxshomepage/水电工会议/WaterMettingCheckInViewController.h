//
//  WaterMettingCheckInViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/6.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0306-总经销-水电工会议-会议详情-会议签到
 **/

#import <UIKit/UIKit.h>

@interface WaterMettingCheckInViewController : UIViewController<AndyDropDownDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;

	EnWaterMettingCheckInSelectItem enselectitem;
	AndyDropDownList *andydroplist;
	NSArray *arrayselectitem;
	int flagnow; //表明当前的是否显示
	
    
    //
    NSString *FCzoneid;
    NSString *FCorderitem;
    NSString *FCorderid;
    
    NSArray *FCarraydata;
    
    NSString *FCordermettinguser;
    NSString *FCordermettingtime;
    UIView *viewtopselectitem;  //顶部选项view
    int FCSelectDropListItem;
}

@property(nonatomic,strong)NSString *FCmettingid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
