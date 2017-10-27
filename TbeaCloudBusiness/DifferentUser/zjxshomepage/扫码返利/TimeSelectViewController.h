//
//  TimeSelectViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/26.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0303-扫码返利-提现数据-时间选择-自定义
 **/

#import <UIKit/UIKit.h>

@interface TimeSelectViewController : UIViewController<PickerTimerDelegate,FDTimeChooserDelegate,FDCityPickerDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
	UITableView *tableview;
	AppDelegate *app;
	
	EnSelectTime enselecttime;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;
@end
