//
//  MallStoreLinkSelectItemViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/13.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 01-02-03-店铺管理-设置-轮换广告-链接页面
 **/

#import <UIKit/UIKit.h>

@interface MallStoreLinkSelectItemViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;


@end
