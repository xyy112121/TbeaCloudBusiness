//
//  AuthNotPassReasonViewController.h
//  TbeaCloudBusiness
//
//  Created by 谢毅 on 2017/11/1.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthNotPassReasonViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    NSArray *FCarraydata;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
