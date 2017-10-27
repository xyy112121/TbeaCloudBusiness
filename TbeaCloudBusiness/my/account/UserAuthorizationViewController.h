//
//  UserAuthorizationViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/12.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0301-01-实名认证-商家分销商-录入商家信息
 **/

#import <UIKit/UIKit.h>

@interface UserAuthorizationViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate>
{
	UITableView *tableview;
	AppDelegate *app;
	
    NSString *FCcompanyname;
    NSString *FClisencecode;
    NSString *FCprovice;
    NSString *FCcity;
    NSString *FCarea;
    NSString *FCaddress;
    NSString *FCbusinesscope;
    NSString *FCcompanylisencepicture;
    UIImage *FCompanylisenceimage;
    NSString *FCmasterperson;
    NSString *FCmasterpersonid;
    NSString *FCpersoncard1;
    UIImage *FCpersoncard1image;
    NSString *FCpersoncard2;
    UIImage *FCpersoncard2image;
    NSString *FCcompanyphoto;
    UIImage *FCcompanyphoto1image;
    UIImage *FCcompanyphoto2image;
    NSString *FCstraddress;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
