//
//  TbeaDetectUserHPViewController.h
//  TbeaCloudBusiness
//
//  Created by 谢毅 on 2017/10/27.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 特变卫士首页  检测人员
 **/

#import <UIKit/UIKit.h>

@interface TbeaDetectUserHPViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    
    EnTbeaHpSelectItem enselectitem;
    NSArray *FCarraytbeatype;
    NSString *FCorderitemvalue;//选择的排序项
    NSString *FCorderid;//选择的排序方式
    NSArray  *FCarraydata;//列表数据
    NSString *FCselectitemid;
    
    NSString *FCinterfacecode;
    NSString *FCordercode;
    NSString *FCorderstatus;
    NSString *FCorderdate;
    
    UIView *sortitem;
    UIView *tabviewheader;
    
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
