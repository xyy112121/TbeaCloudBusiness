//
//  ModelSelectViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/23.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0201-04-返利二维码生成-规格选择
 **/

#import <UIKit/UIKit.h>

@interface ModelSelectViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	NSArray *FCarraymodelselect;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property(nonatomic,strong)NSString *strmodel;
@end
