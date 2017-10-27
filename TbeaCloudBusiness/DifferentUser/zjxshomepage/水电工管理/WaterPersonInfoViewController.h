//
//  WaterPersonInfoViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0801-水电工个人页面-个人资料
 **/

#import <UIKit/UIKit.h>

@interface WaterPersonInfoViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
    NSDictionary *FCdicdata;
}

@property(nonatomic,strong)NSString *FCelectricianid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;


@end
