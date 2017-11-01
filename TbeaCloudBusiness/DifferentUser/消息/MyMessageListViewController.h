//
//  MyMessageListViewController.h
//  TbeaCloudBusiness
//
//  Created by 谢毅 on 2017/11/1.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 消息类容列表
 **/

#import <UIKit/UIKit.h>

@interface MyMessageListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    NSArray *FCarraydata;
    
}

@property(nonatomic,strong)NSString *FCcategoryid;
@end
