//
//  MyMessageViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/1/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 消息种类列表
 **/

#import <UIKit/UIKit.h>

@interface MyMessageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	NSArray *arraydata;
}

@end
