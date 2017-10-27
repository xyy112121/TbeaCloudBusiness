//
//  OnlineOrderDetailViewController.h
//  TeBian
//
//  Created by xyy520 on 15/12/22.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "ActionDelegate.h"
@interface OnlineOrderDetailViewController : UIViewController<ActionDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIActionSheetDelegate>
{
	NSArray *arraydata;
	NSString *totalmoney;
	NSMutableArray *content1;
	NSMutableArray *content2;
	NSMutableArray *content3;
	NSString *result;
	NSString *result1;
	NSString *result2;
	UIView *maskView;
	NSDictionary *dickehu;
	NSDictionary *dicpreorderinfo;
	NSString *pricetypeid;
	NSString *customid;
}
@property(nonatomic,strong)NSString *strorderid;
@property(nonatomic,strong)NSString *addproductflag;  //1表示新添加的产品 2表示产品列表
@property(nonatomic,strong)IBOutlet UITableView *tableview;
@property(nonatomic,strong)id<ActionDelegate> delegate1;
@end
