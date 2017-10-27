//
//  TbeaBuySomeProductViewController.h
//  TbeaCloudBusiness
//
//  Created by 谢毅 on 2017/10/25.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TbeaBuySomeProductViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource,YBPopupMenuDelegate>
{
    UITableView *tableview;
    AppDelegate *app;

    NSArray *FCarraydata;

    
    
    
}
@property(nonatomic,strong)NSString *FCvouchercode;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
