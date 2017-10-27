//
//  DistributorMangerViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/9/5.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistributorMangerViewController : UIViewController<AndyDropDownDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    
    EnSortMoreSelectItem enselectitem;
    EnScanRebateHpUserType enusertype;//当前选择的用户类型
    
    AndyDropDownList *andydroplist;
    NSMutableArray *arrayselectitem;
    int flagnow; //表明当前的是否显示
    
    //
    NSArray *FCarraydata;
    
    //
    NSString *FCorderid;
    NSString *FCorderitem;
    NSString *FCstarttime;
    NSString *FCendtime;
    NSString *FCzonelds;
    
    
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
