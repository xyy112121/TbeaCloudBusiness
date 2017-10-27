//
//  TiXianDataDetailViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/26.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0304-扫码返利-提现数据-提现详情
 **/
#import <UIKit/UIKit.h>

@interface TiXianDataDetailViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	
	NSDictionary *FCdicdata;
	
}

@property(nonatomic,strong)NSString *FCtakemoneyid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;


@end
