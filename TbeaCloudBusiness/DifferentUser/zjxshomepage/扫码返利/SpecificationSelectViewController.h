//
//  SpecificationSelectViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/23.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0201-02-返利二维码生成-型号选择
 **/

#import <UIKit/UIKit.h>

@interface SpecificationSelectViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	NSArray *FCarrayspecifi;//型号规格
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property(nonatomic,strong)NSString *strspecification;
@end
