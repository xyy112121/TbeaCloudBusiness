//
//  AreaSelectViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/30.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaSelectViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	NSMutableArray *selectarray;
	NSArray *FCarrayarea;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
