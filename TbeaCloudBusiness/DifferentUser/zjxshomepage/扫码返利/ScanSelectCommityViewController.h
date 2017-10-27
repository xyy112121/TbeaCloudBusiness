//
//  ScanSelectCommityViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/10/16.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 选择产品名称
 **/

#import <UIKit/UIKit.h>

@interface ScanSelectCommityViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    NSArray *FCarraydata;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property(nonatomic,strong)NSString *strspecification;

@end
