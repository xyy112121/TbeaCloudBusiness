//
//  UserInfoMakeUpViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/9.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 对应 的界面0203-01-注册-分销商-补全资料
**/

#import <UIKit/UIKit.h>

@interface UserInfoMakeUpViewController : UIViewController<FDCityPickerDelegate,PickerTimerDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
	UITableView *tableview;
	AppDelegate *app;
	
    NSArray *FCarraymakeuplist;
    UIImage *FCimage;
    
    NSString *FCuploadstrpic; //图片路径
    NSString *FCcompanyid;
    NSString *FCprovice;
    NSString *FCcity;
    NSString *FCarea;
    NSString *FCrealname;
    NSString *FCsex;
    NSString *FCyear;
    NSString *FCmonth;
    NSString *FCday;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
