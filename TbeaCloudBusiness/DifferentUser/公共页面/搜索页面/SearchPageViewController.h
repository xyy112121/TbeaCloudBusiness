//
//  SearchPageViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/29.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchPageViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,ActionDelegate>
{
	AppDelegate *app;
	NSMutableArray *arraydata;
	NSArray *arrayhot;
	UITableView *tableview;
}

@property(nonatomic,strong)NSString *FCSearchFromType;
@end
