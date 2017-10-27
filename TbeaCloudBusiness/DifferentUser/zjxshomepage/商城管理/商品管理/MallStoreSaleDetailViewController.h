//
//  MallStoreSaleDetailViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/31.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**销售详情**/

#import <UIKit/UIKit.h>

@interface MallStoreSaleDetailViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    NSDictionary *FCcommdityinfo;
    NSDictionary *FCsaleinfo;
}

@property(nonatomic,strong)NSString *FCcommodityid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
