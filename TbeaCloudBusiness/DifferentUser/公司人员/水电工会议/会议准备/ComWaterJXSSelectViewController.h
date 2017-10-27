//
//  ComWaterJXSSelectViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/31.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**0203-公司人员-水电工会议-准备-经销商选择(多选)**/

#import <UIKit/UIKit.h>

@interface ComWaterJXSSelectViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    
    NSArray *FCarraydata;
    NSMutableArray *FCarrayselectdata;
    
}
@property(nonatomic,strong)NSArray *FCselectdata;
@property(nonatomic,strong)NSString *FCmettingid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
