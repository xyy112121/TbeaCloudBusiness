//
//  ScanQRZhiFuDoneViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanQRZhiFuDoneViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
}


@property(nonatomic,strong)NSDictionary *FCdicscancodedetail;
@property(nonatomic,strong)id<ActionDelegate>delegate1;


@end
