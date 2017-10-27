//
//  MyPageModifyPhoneViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/19.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPageModifyPhoneViewController : UIViewController<UITextFieldDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	int getyanzhengcodeflag;
	NSTimer * timerone;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
