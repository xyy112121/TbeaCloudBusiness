//
//  ComWaterPersonMangerZJXViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/14.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**公司人员 水电工管理首页 显示出所有总经销商列表**/

#import <UIKit/UIKit.h>

@interface ComWaterPersonMangerZJXViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    

    int flagnow; //表明当前的是否显示
    
    //排序
    
    NSString *FCorderitem;
    NSString *FCorderid;

    //
    NSArray *FCarraydata;
    NSDictionary *FCdicelectricianinfo;
    
    UIView *viewtop;
}
@property(nonatomic,strong)NSString *FCfromflag;//1 外勤人员水电工管理进入  2 外勤人员扫码返利
@property(nonatomic,strong)NSString *FCelectricianid;
@property(nonatomic,strong)NSString *FCpersontype;
@property(nonatomic,strong)NSString *FCpayeeid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property(nonatomic)EnScanRebateHpUserType enfromusertype;

@end
