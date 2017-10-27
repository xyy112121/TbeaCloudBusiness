//
//  WaterMettingDetailViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/5.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0301-总经销-水电工会议-会议详情
 **/

#import <UIKit/UIKit.h>

@interface WaterMettingDetailViewController : UIViewController<YBPopupMenuDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
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
    
    NSString *FCmettingpicturenum;//图片数目
    NSString *FCmettingsummary;//会议纪要
    
    NSString *FCmettingstatus;
}

@property(nonatomic,strong)NSString *FCmettingid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
