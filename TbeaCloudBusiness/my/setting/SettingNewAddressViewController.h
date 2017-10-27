//
//  SettingNewAddressViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/19.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0103-02-我的-设置-收货地址-新增
 **/

#import <UIKit/UIKit.h>

@interface SettingNewAddressViewController : UIViewController<FDCityPickerDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
	UITableView *tableview;
	AppDelegate *app;
	EnSelectType isselect;
    NSString *FCname;
    NSString *FCtel;
    NSString *FCprovice;
    NSString *FCcity;
    NSString *FCarea;
    NSString *FCaddress;
    NSString *FCisdefault;
}

@property(nonatomic,strong)NSString *FCaddressid;
@end
