//
//  DistributorRebateHpViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/8.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**分销商扫码返利首页**/

#import <UIKit/UIKit.h>

@interface DistributorRebateHpViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource,YBPopupMenuDelegate>
{
    UITableView *tableview;
    AppDelegate *app;
    
    NSArray *FCarraydata; // 列表数据
    NSDictionary *FCdictakemoney;//提现dic
}


@end
