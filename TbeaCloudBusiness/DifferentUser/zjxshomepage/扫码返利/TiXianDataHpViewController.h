//
//  TiXianDataHpViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/25.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0301-扫码返利-提现数据-已支付  未支付
 **/

#import <UIKit/UIKit.h>

@interface TiXianDataHpViewController : UIViewController<AndyDropDownDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	
	EnTiXianDataZhiFuType zhifutype;
	EnTiXianDataSelectItem enselectitem;
	
	
	AndyDropDownList *andydroplist;
	NSMutableArray *arrayselectitem;
	int flagnow; //表明当前的是否显示
	
	//
	NSString *FCorderitem;
	NSString *FCorderid;
	NSString *FCstarttime;
	NSString *FCendtime;
	NSString *FCpaystatusid;
	NSString *FCpayeeusertypeid;
	
	//
	NSArray *FCarraydata;
	NSDictionary *FCdictotleinfo;
	//
	NSArray *FCarrayPayeeUsertype;
	NSArray *FCarraypaystatus;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
