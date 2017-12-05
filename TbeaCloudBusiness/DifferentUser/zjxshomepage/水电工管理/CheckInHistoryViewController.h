//
//  CheckInHistoryViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/*
 0401-水电工个人页面-签到历史
 */

#import <UIKit/UIKit.h>

@interface CheckInHistoryViewController : UIViewController<AndyDropDownDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	
	EnCheckInSelectItem enselectitem;
	
    //参数
    NSString *FCmeetingcode;
    NSString *FCzoneid;
    NSString *FCstartdate;
    NSString *FCenddate;
    NSString *FCorderitem;
    NSString *FCorder;
    
    //
    NSMutableArray *arrayselectitem;
    NSArray *FCarraydata;
    NSDictionary *FCdicdata;
    
	AndyDropDownList *andydroplist;
	int flagnow; //表明当前的是否显示
    
    UIView *viewtopselectitem;  //顶部选项view
    int FCSelectDropListItem;
	
}
@property(nonatomic,strong)NSString *FCelectricianid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
