//
//  MallStoreSpecialModuleListViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/28.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**型号规格管理列表**/

#import <UIKit/UIKit.h>

@interface MallStoreSpecialModuleListViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    NSArray *FCarraydata;
}
@property(nonatomic,strong)NSString *FCtitle;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
