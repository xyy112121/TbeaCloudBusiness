//
//  MyPageViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/18.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0000-我的-总经销商
 **/

#import <UIKit/UIKit.h>

@interface MyPageViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
    NSArray *arrayitemlist;
    NSDictionary *FCdicuserpersoninfo;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
