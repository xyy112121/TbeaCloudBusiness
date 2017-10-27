//
//  MallStoreDynamicListViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/9/1.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MallStoreDynamicListViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    
    EnSelectType isallselect;
    EnSelectType isedit;
    NSMutableArray *selectarray;
    NSString *FCselectids;
    NSArray *FCarraydata;
    
    UIView *viewbottom;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
