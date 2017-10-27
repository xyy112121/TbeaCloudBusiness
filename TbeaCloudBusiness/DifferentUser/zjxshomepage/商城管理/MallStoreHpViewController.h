//
//  MallStoreHpViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/7/7.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MallStoreHpViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	AlertViewExtension *alert;
	AppDelegate *app;
	UITableView *tableview;
	NSArray *FCarrayfunction;
	NSArray *FCarraystaticsitem;
    NSMutableArray *FCarrayheigt;
}


@end
