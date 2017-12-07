//
//  DistributorTiXianHistoryViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/9/6.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistributorTiXianHistoryViewController : UIViewController<AndyDropDownDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
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
    
    UIView *FCtopview;
    int FCSelectDropListItem;
    //
    NSArray *FCarraydata;
    NSDictionary *FCdicpayeeinfo;
}
@property(nonatomic,strong)NSString *FCdistributorid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
