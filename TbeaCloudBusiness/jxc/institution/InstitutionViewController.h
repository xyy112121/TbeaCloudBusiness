//
//  InstitutionViewController.h
//  TeBian
//
//  Created by xyy520 on 15/12/17.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "ActionDelegate.h"
@interface InstitutionViewController : UIViewController<ActionDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
	NSArray *arraydata;
	NSArray *arraydatacategory;
	NSString *strcategoryid;
}
@property(nonatomic,strong)IBOutlet UITableView *tableview;

@end
