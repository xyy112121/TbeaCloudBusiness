//
//  SettingModifyPwdViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/19.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/***
 0102-01-我的-设置-密码设置
 
 **/

#import <UIKit/UIKit.h>

@interface SettingModifyPwdViewController : UIViewController<UITextFieldDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
