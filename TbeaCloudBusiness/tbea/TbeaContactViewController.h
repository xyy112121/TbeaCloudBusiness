//
//  TbeaContactViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/15.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0040-01-特变电工-联系方式
 **/
#import <UIKit/UIKit.h>

@interface TbeaContactViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
    
    NSDictionary *FCdiccontact;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
