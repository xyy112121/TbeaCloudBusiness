//
//  HomePageViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/17.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageViewController : UIViewController<ActionDelegate,alertviewExtensionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	AlertViewExtension *alert;
	AppDelegate *app;
	UITableView *tableview;
	NSArray *arrayfunction;
	NSArray *arraystaticsitem;
	NSArray *arraymessage;
}
@end
