//
//  MyPageModifyPhoneNewViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/19.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0101-01-我的-设置-手机号码-更换手机号码
 **/

#import <UIKit/UIKit.h>

@interface MyPageModifyPhoneNewViewController : UIViewController<UITextFieldDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	int getyanzhengcodeflag;
	NSTimer * timerone;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
