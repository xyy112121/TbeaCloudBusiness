//
//  SettingAddressViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/19.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0103-01-我的-设置-收货地址
 **/

#import <UIKit/UIKit.h>

@interface SettingAddressViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
	UITableView *tableview;
	AppDelegate *app;
	NSMutableArray *FCarraydata;
}

@property(nonatomic,strong)NSString *fromaddr;//1表示从地址管理进来  2表示从购买商品进来  3表示商品详情选取的地址
@property(nonatomic,strong)id<ActionDelegate>delegate1;


@end
