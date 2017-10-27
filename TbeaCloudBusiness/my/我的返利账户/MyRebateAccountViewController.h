//
//  MyRebateAccountViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/16.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRebateAccountViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    NSMutableArray *arraydata;
    NSDictionary *dicdata;
    
}


@end
