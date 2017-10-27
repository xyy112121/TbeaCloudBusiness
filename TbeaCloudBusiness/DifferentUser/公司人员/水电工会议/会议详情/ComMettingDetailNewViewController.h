//
//  ComMettingDetailNewViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/13.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**会议详情 新会议
 
 会议会为4种状态  
 1.新会议  24小时前  可编辑 ，可删除  new
 2.准备中   24小时内  可编辑 ，不可删除  preparing
 3.开会中   开会中，不可编辑 ，不可删除，可更新  meeting
 4.结束会议    不可编辑 ，不可删除   finish
 
 对应会议状态的preparing，即可编辑 ，但不能删除   **/


#import <UIKit/UIKit.h>

@interface ComMettingDetailNewViewController : UIViewController<YBPopupMenuDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    NSDictionary *FCdicdata;
    YBPopupMenu *ybpopmenu;
    
    EnMettingEditStatus editstatus;
    
    NSArray *FCarrayjibandanwei;//举办单位个数
    NSString *FCjubandanweiids; //举办单位ids
    NSArray *FCarrayjoinmember;//参与人员
    NSString *FCjoinmemberids;//参与人员ids
    NSString *FCstarttime; //开始时间
    NSString *FCendtime; //结束时间
    NSString *FCstrtime; //举行时间
    
    NSString *FCmettingarrangement;//会议安排
    NSString *FCprovice;
    NSString *FCcity;
    NSString *FCarea;
    NSString *FCspecificaddress; //区以下的地址
    NSString *FCstraddress;  //全部详细地址
    
    NSString *FCparticipantnumber; //会议number
}

@property(nonatomic,strong)NSString *FCmettingid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
