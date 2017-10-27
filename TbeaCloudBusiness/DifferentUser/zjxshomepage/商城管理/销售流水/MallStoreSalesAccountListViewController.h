//
//  MallStoreSalesAccountListViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/9/3.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**销售流水**/

#import <UIKit/UIKit.h>

@interface MallStoreSalesAccountListViewController : UIViewController<UITextFieldDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    NSDictionary *FCcommdityinfo;
    NSDictionary *FCsaleinfo;
    NSArray *FCarraydata;
    
    NSString *FCstartime;
    NSString *FCendtime;
    NSString *FCorderitem;
    NSString *FCorderid;
    
    NSString *FCselecttime;
    
    UITextField *FCtextfield;
    UILabel *FClablemoneyvalue;
    UILabel *FClableallmoneyflag;
}

@property(nonatomic,strong)NSString *FCcommodityid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
