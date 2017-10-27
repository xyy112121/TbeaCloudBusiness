//
//  SonAccountMangerViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/20.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0201-01-我的-子账号
 **/

#import <UIKit/UIKit.h>

@interface SonAccountMangerViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
    NSArray *FCarraydata;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
