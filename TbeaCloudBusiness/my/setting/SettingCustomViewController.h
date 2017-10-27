//
//  SettingCustomViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/19.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0105-01-我的-设置-通用
 **/

#import <UIKit/UIKit.h>

@interface SettingCustomViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
