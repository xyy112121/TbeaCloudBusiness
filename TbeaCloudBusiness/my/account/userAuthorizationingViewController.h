//
//  userAuthorizationingViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/21.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0301-01-实名认证-商家分销商-录入商家信息   只显示
 **/
#import <UIKit/UIKit.h>

@interface userAuthorizationingViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate>
{
    UITableView *tableview;
    AppDelegate *app;
    
    NSString *FCcompanyname;
    NSString *FClisencecode;
    NSString *FCaddress;
    NSString *FCbusinesscope;
    NSString *FCcompanylisencepicture;
    NSString *FCmasterperson;
    NSString *FCmasterpersonid;
    NSString *FCpersoncard1;
    NSString *FCpersoncard2;
    NSString *FCcompanyphoto;
    NSString *FCstraddress;
}
@property(nonatomic,strong)NSString *FCidentifystatus;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
