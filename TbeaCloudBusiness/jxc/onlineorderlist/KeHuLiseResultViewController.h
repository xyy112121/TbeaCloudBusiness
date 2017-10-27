//
//  KeHuLiseResultViewController.h
//  TeBian
//
//  Created by xyy520 on 16/1/25.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "ActionDelegate.h"
@interface KeHuLiseResultViewController : UIViewController<ActionDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
	NSArray *arraydata;
}
@property(nonatomic,strong)IBOutlet UITableView *tableview;
@property(nonatomic,strong)NSString *strpcode;
@property(nonatomic,strong)NSString *strpname;
@property(nonatomic,strong)NSString *strpdes;
@property(nonatomic,strong)id<ActionDelegate> delegate1;
@property(nonatomic,strong)id<ActionDelegate> delegate2;

@end
