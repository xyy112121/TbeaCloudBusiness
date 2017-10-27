//
//  SonAccountAddNewViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/20.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0202-01-我的-子账号-新增
 **/

#import <UIKit/UIKit.h>

@interface SonAccountAddNewViewController : UIViewController<PickerTimerDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
	UITableView *tableview;
	AppDelegate *app;
    
    NSArray *FCarrayauthorization;
    NSString *FCtel;
    NSString *FCname;
    NSString *FCusertype;
    NSString *FCusertypeid;
    NSString *FCsex;
    NSString *FCyear;
    NSString *FCmonth;
    NSString *FCday;
    NSString *FCpwd;
    NSString *FCjobtitle;
    NSString *FCpicpath;
    UIImage *FCimage;
}
@property(nonatomic,strong)NSString *FCpersonid;
@property(nonatomic,strong)NSString *FCisedit;//可否编辑
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
