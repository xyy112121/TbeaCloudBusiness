//
//  TbeaPageViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/18.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0000-特变电工-首页
 **/

#import <UIKit/UIKit.h>

@interface TbeaPageViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
    NSArray *FCarrayfocus;
    NSArray *FCarrayproduct;
    NSArray *FCarraymessage;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
