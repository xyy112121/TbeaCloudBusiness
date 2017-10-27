//
//  UserInfoMakeUpingViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/21.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**补全资料  只显示**/

#import <UIKit/UIKit.h>

@interface UserInfoMakeUpingViewController : UIViewController<FDCityPickerDelegate,PickerTimerDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *tableview;
    AppDelegate *app;
    
    NSArray *FCarraymakeuplist;
    UIImage *FCimage;
    
    NSString *FCuploadstrpic; //图片路径
    NSString *FCcompanyname;
    NSString *FCprovice;
    NSString *FCcity;
    NSString *FCarea;
    NSString *FCaddress;
    NSString *FCrealname;
    NSString *FCsex;
    NSString *FCyear;
    NSString *FCmonth;
    NSString *FCday;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
