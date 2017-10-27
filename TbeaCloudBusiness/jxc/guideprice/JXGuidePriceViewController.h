//
//  JXGuidePriceViewController.h
//  TeBian
//
//  Created by xyy520 on 15/12/16.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "ActionDelegate.h"
@interface JXGuidePriceViewController : UIViewController<ActionDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
	NSArray *arraydata;
	NSString *strsearchname;

}
@property(nonatomic,strong)IBOutlet UITableView *tableview;

@end
