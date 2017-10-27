//
//  TbeaDetectUserWeiJieDanViewController.h
//  TbeaCloudBusiness
//
//  Created by 谢毅 on 2017/10/27.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**检测人员  特变卫士  待处理详情  在此处接单**/

#import <UIKit/UIKit.h>

@interface TbeaDetectUserWeiJieDanViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    
    NSDictionary *FCdicdata;
    
}

@property(nonatomic,strong)NSString *FCelectricalcheckid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
