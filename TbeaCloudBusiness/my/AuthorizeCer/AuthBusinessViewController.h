//
//  AuthBusinessViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/21.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0302-01-实名认证-状态-商家分销商-未通过  审核中   已通过
 **/

#import <UIKit/UIKit.h>

@interface AuthBusinessViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
    NSDictionary *FCcompanyidentifyinfo;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
