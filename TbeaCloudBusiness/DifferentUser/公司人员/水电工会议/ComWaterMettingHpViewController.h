//
//  ComWaterMettingHpViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/31.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**公司人员水电工会议主页**/

#import <UIKit/UIKit.h>

@interface ComWaterMettingHpViewController : UIViewController<AndyDropDownDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
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
    
    NSString *FCordertime;
    NSString *FCordercode;
    int FCSelectDropListItem;
    //
    int prentflag;//跳转
    NSString *FCcommitmettingid;
    
    AndyDropDownList *andydroplist;
    NSMutableArray *arrayselectitem;
    int flagnow; //表明当前的是否显示
    
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
