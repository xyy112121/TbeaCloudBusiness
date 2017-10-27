//
//  ScanCodeDetailViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/25.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0201-04-返利二维码  扫码详情
 **/

#import <UIKit/UIKit.h>

@interface ScanCodeDetailViewController :UIViewController <ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	NSDictionary *FCdicscancodedetail;
}


@property(nonatomic,strong)NSString *FCqrcodeactivityid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;


@end
