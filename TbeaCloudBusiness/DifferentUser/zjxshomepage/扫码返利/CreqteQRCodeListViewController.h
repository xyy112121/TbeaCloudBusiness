//
//  CreqteQRCodeListViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/7/3.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
  生成二维码结果查看
 **/

#import <UIKit/UIKit.h>

@interface CreqteQRCodeListViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	
	NSString *FCactivitestatusid;
	
	NSArray *FCarraydata;
	NSDictionary *FCrebateinfo;
	
	
	
}

@property(nonatomic,strong)NSString *FCcreateid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property(nonatomic)EnScanRebateHpUserType enfromusertype;

@end
