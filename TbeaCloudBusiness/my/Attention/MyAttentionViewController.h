//
//  MyAttentionViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/21.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 我的-我的关注-商品  人   商铺
 **/

#import <UIKit/UIKit.h>

@interface MyAttentionViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
	EnAttentionSelectMenuItem attentionselectitem;
	EnSelectType isedit;
	NSMutableArray *selectarray;
    NSString *FCselectids;
    NSArray *FCarraydata;
}
@property(nonatomic,strong)NSString *FCuserid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
