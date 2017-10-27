//
//  TbeaYiPaiDanDetailViewController.h
//  TbeaCloudBusiness
//
//  Created by 谢毅 on 2017/10/24.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 已派单详情
 **/

#import <UIKit/UIKit.h>

@interface TbeaYiPaiDanDetailViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    
    NSDictionary *FCdicdata;
    
}

@property(nonatomic,strong)NSString *FCelectricalcheckid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
