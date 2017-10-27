//
//  WaterPersonMangerViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/29.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/*
 总经销-水电工管理
 */

#import <UIKit/UIKit.h>

@interface WaterPersonMangerViewController : UIViewController<AndyDropDownDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	
	EnSortMoreSelectItem enselectitem;
	EnMoneySortSelect  FCmoneysorttype;//当前 选择的money 排序类型
	
	NSArray  *FCarraydata;//列表数据
	NSArray  *FCarrayelectric;//水电工类型
	NSString *FCwatertypeid;//选择的水电工id
	NSString *FCzoneid;//选择的区域id
	NSString *FCorderitemvalue;//选择的排序项
	NSString *FCorderid;//选择的排序方式
	NSString *FCsearchname;//搜索时的名称
	
	AndyDropDownList *andydroplist;
	NSMutableArray *arrayselectitem;
	int flagnow; //表明当前的是否显示
	
}
@property(nonatomic,strong)NSString *FCzjxid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
