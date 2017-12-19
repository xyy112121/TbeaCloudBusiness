//
//  ComMettingDetailPreparingViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/13.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**会议详情 即准备中
 
 会议会为4种状态
 【新会议状态】会议开始前24小时: 可编辑,可删除，不可更新   new
 【准备中状态】会议开始前24小时到会议开始: 不可编辑,不可删除，不可更新  preparing
 【会议中状态】会议开始到会议结束: 不可编辑,不可删除，可更新   meeting
 【已结束状态】会议结束到会议结束后72小时: 不可编辑,不可删除，可更新  finish
 【已关闭状态】会议已结束后的状态: 不可编辑,不可删除，不可更新
 
 对应会议状态的preparing，即可编辑 ，但不能删除   **/

#import <UIKit/UIKit.h>

@interface ComMettingDetailPreparingViewController : UIViewController<YBPopupMenuDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
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
@property(nonatomic,strong)NSString *FCmeetingsponsorid;
@property(nonatomic,strong)NSString *FCmettingid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
