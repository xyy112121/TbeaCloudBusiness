//
//  MallStoreLinkSelectItemPageViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/13.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 01-02-05-店铺管理-设置-轮换广告-链接页面-店铺商品
 **/

#import <UIKit/UIKit.h>

@interface MallStoreLinkSelectItemPageViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    
    NSString *FCorder;
    NSString *FCorderid;
    NSArray *FCarraydata;
    
    EnMallStoreLinkSelecttype linkselectitem;
    
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
