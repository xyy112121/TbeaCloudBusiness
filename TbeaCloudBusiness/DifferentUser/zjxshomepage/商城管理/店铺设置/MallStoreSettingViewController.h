//
//  MallStoreSettingViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/7/7.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MallStoreSettingViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
