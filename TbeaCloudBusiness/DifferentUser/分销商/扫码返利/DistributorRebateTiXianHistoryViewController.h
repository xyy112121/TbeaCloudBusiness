//
//  DistributorRebateTiXianHistoryViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/8.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**分销商提现历史列表**/

#import <UIKit/UIKit.h>

@interface DistributorRebateTiXianHistoryViewController : UIViewController<AndyDropDownDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
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
