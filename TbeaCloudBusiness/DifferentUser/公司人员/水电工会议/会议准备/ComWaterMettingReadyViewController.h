//
//  ComWaterMettingReadyViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/31.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/*发起会议*/

#import <UIKit/UIKit.h>

@interface ComWaterMettingReadyViewController : UIViewController<alertviewExtensionDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    AlertViewExtension *alert;
    UITableView *tableview;
    AppDelegate *app;
    NSDictionary *FCdicdata;
    
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
}

@property(nonatomic,strong)NSString *FCmettingid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
