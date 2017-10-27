//
//  TbeaNewsListViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/14.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0020-01-特变电工-新闻资讯
 **/

#import <UIKit/UIKit.h>

@interface TbeaNewsListViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
    NSString *FCcategory;
    NSArray *FCarraydata;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
