//
//  ContactViewController.h
//  TeBian
//
//  Created by xyy520 on 15/12/19.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "ActionDelegate.h"
@interface ContactViewController : UIViewController<ActionDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
	NSArray *arraydata;

}
@property(nonatomic,strong)IBOutlet UITableView *tableview;


@end
