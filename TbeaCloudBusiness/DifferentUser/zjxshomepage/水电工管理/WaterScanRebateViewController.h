//
//  WaterScanRebateViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/1.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0301-水电工个人页面-卡片-点击三点页面-扫码
 **/

#import <UIKit/UIKit.h>

@interface WaterScanRebateViewController : UIViewController<AndyDropDownDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	
	EnWaterScanTianType selecttype;  //顶部的扫码还是提现
	EnWaterScanSelectItem enselectitem; //下面选择的是时间还是状态还是型号
	
    
    //参数
    
	NSString *FCstartdate;
    NSString *FCenddate;
    NSString *FCcommoditymodelspecification;
    NSString *FCconfirmstatusid;
    NSString *FCorderitem;
    NSString *FCorder;
    
    //状态
    NSArray *FCarraystatus;
    NSArray *FCarrayxinhao;
    NSMutableArray *arrayselectitem;
    NSArray *FCarraydata;
    
    
	AndyDropDownList *andydroplist;
	int flagnow; //表明当前的是否显示
    
    UIView *viewtopselectitem;  //顶部选项view
    int FCSelectDropListItem;
	
}
@property(nonatomic,strong)NSString *FCelectricianid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
