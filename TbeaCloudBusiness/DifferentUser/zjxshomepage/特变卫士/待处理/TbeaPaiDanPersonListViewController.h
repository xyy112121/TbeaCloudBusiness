//
//  TbeaPaiDanPersonListViewController.h
//  TbeaCloudBusiness
//
//  Created by 谢毅 on 2017/10/24.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 派单人员列表
 **/

#import <UIKit/UIKit.h>

@interface TbeaPaiDanPersonListViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    
    NSArray *FCarraydata;
    NSDictionary *FCdicselectdata;
}
@property(nonatomic,strong)NSString *FCjoinmemberids;
@property(nonatomic,strong)NSString *FCmettingid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
