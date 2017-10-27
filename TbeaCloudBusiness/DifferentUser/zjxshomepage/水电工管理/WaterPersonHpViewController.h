//
//  WaterPersonHpViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/31.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/*
 
 水电工个人主页-管理页面  是通过WaterPersonHpInfoViewController的右上角管理进入此页面
 */

#import <UIKit/UIKit.h>

@interface WaterPersonHpViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	EnWaterPersonHpFunctionType functiontype;
    NSDictionary *FCdicdata;
}

@property(nonatomic,strong)NSString *FCelectricianid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
