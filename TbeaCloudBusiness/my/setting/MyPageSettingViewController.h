//
//  MyPageSettingViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/16.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0100-01-我的-设置
 **/

#import <UIKit/UIKit.h>

@interface MyPageSettingViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
    NSString *FCtel;
    NSString *FCreceivenum;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
