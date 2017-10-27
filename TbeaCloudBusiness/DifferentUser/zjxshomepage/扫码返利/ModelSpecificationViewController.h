//
//  ModelSpecificationViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/23.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0201-01-返利二维码生成-型号规格-选择完毕
 **/
#import <UIKit/UIKit.h>

@interface ModelSpecificationViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	NSString *strmodel; //规格
	NSString *strmodelid; //规格
	NSString *strspecification;//型号
	NSString *strspecificationid;//型号
}


@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
