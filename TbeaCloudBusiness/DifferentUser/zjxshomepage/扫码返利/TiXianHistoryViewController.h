//
//  TiXianHistoryViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/26.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0404-扫码返利-提现数据-用户历史-分销商
 **/

#import <UIKit/UIKit.h>

@interface TiXianHistoryViewController : UIViewController<AndyDropDownDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	
	EnTiXianDataSelectItem enselectitem;
	
	AndyDropDownList *andydroplist;
	NSMutableArray *arrayselectitem;
	int flagnow; //表明当前的是否显示
	
	//排序
	NSString *FCorderitem;
	NSString *FCorderid;
	NSString *FCstarttime;
	NSString *FCendtime;
    NSString *FCmoney;
    NSString *FCtime;
	//
	NSArray *FCarraydata;
	NSDictionary *FCdicpayeeinfo;
    UIView *sortitemview;
}
@property(nonatomic,strong)NSString *FCpersontype;
@property(nonatomic,strong)NSString *FCpayeeid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property(nonatomic)EnScanRebateHpUserType enfromusertype;
@end
