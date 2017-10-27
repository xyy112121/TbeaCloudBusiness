//
//  ScanRebatehpViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/21.
//  Copyright © 2017年 谢 毅. All rights reserved.
//
/**
 0101-扫码返利-混合排行
 **/

#import <UIKit/UIKit.h>

@interface ScanRebatehpViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource,YBPopupMenuDelegate>
{
	UITableView *tableview;
	AppDelegate *app;
	
	NSArray *FCarraydata; // 列表数据
	NSDictionary *FCdictakemoney;//提现dic
}
@end
