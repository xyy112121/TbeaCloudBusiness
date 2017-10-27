//
//  JXOrderListViewController.h
//  TeBian
//
//  Created by xyy520 on 15/12/14.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "ActionDelegate.h"
@interface JXOrderListViewController : UIViewController<ActionDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIActionSheetDelegate>
{
	NSArray *arraydata;
	NSArray *arrayatt;
	NSString *strstatusid;
	NSString *strcode;
	NSString *strstartdate;
	NSString *strenddate;
	NSMutableArray *content1;
	NSMutableArray *content2;
	NSMutableArray *content3;
	NSString *result;
	NSString *result1;
	NSString *result2;
	UIView *maskView;
	int selectmodel;
}
@property(nonatomic,strong)IBOutlet UITableView *tableview;
@end
