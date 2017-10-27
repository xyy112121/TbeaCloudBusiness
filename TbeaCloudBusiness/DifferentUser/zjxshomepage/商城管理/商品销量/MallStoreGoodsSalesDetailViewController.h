//
//  MallStoreGoodsSalesDetailViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/9/3.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**商品销量详情**/

#import <UIKit/UIKit.h>

@interface MallStoreGoodsSalesDetailViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    NSDictionary *FCcommdityinfo;
    NSDictionary *FCsaleinfo;
    NSArray *FCarraydata;
}

@property(nonatomic,strong)NSString *FCcommodityid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
