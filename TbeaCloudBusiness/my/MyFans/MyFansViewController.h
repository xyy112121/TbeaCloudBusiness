//
//  MyFansViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/21.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 我的-我的粉丝
 **/

#import <UIKit/UIKit.h>

@interface MyFansViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	EnSelectType isedit;
	NSMutableArray *selectarray;
    NSArray *FCarraydata;
    NSString *FCselectids;
}
@property(nonatomic,strong)NSString *FCuserid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
