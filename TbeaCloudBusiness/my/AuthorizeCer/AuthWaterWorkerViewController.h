//
//  AuthWaterWorkerViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/21.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0301-01-实名认证-状态-水电工-未通过  已通过  审核中
 **/

#import <UIKit/UIKit.h>

@interface AuthWaterWorkerViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;


@end
