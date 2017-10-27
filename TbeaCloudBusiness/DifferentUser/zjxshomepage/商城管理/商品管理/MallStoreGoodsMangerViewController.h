//
//  MallStoreGoodsMangerViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/28.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**商品管理列表**/

#import <UIKit/UIKit.h>

@interface MallStoreGoodsMangerViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    
    NSString *FCorder;
    NSString *FCorderid;
    NSArray *FCarraydata;
    NSString *FCtotlecommoditynumber;
    UIButton *FCButtonnumber;
    
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;


@end
