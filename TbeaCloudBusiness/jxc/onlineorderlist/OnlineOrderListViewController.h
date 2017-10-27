//
//  OnlineOrderListViewController.h
//  TeBian
//
//  Created by xyy520 on 15/12/21.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "ActionDelegate.h"
@interface OnlineOrderListViewController : UIViewController<ActionDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
	NSArray *arraydata;
}
@property(nonatomic,strong)IBOutlet UITableView *tableview;

@end
