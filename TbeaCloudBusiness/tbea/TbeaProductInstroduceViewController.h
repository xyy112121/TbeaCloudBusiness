//
//  TbeaProductInstroduceViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/14.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0030-01-特变电工-产品介绍
 **/

#import <UIKit/UIKit.h>

@interface TbeaProductInstroduceViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource,YBPopupMenuDelegate>
{
    UITableView *tableview;
    AppDelegate *app;
    YBPopupMenu *ybpopmenu;
    NSString *FCname;
    NSString *FCcategoryid;  //类别ID
    NSString *FCspecificationid;  //规格
    NSString *FCspecificationname;  //规格
    NSString *FCmodelid;   //型号
    NSString *FCmodelname;   //型号
    NSString *FCorderitem;
    NSString *FCorderid;
    NSArray *FCarraydata;
    NSArray *FCarraymodel; //型号
    NSArray *FCarrayspeci; //规格
    NSArray *FCarraycategory;//类别
    EnTbeaProductListType selectitem;
    
    AndyDropDownList *andydroplist;
    NSMutableArray *arrayselectitem;
    int flagnow; //表明当前的是否显示
    
    
    
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
