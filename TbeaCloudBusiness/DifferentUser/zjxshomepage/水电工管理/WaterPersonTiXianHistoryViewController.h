//
//  WaterPersonTiXianHistoryViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/5.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**水电工管理里的提现历史 **/

#import <UIKit/UIKit.h>

@interface WaterPersonTiXianHistoryViewController : UIViewController<AndyDropDownDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
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
    NSString *FCstartdate;
    NSString *FCenddate;
    
    
    //
    NSArray *FCarraydata;
    NSDictionary *FCdicelectricianinfo;
}
@property(nonatomic,strong)NSString *FCelectricianid;
@property(nonatomic,strong)NSString *FCpersontype;
@property(nonatomic,strong)NSString *FCpayeeid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property(nonatomic)EnScanRebateHpUserType enfromusertype;

@end
