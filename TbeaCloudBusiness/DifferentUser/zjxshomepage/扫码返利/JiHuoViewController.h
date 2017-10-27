//
//  JiHuoViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/25.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0204-返利二维码生成-历史记录-已激活
 **/

#import <UIKit/UIKit.h>

@interface JiHuoViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	
	AndyDropDownList *andydroplist;
	NSArray *arrayselectitem;
	int flagnow; //表明当前的是否显示
	
	//
	NSArray *FCarraydata;
	
	//
	NSString *FCorderitem;
	NSString *FCorderid;
	
}

@property(nonatomic,strong)NSString *FCqrcodeid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@end
