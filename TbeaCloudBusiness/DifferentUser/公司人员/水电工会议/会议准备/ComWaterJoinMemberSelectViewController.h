//
//  ComWaterJoinMemberSelectViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/1.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**0204-公司人员-水电工会议-准备-内部人员选择(多选)**/

#import <UIKit/UIKit.h>

@interface ComWaterJoinMemberSelectViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    
    NSArray *FCarraydata;
    NSMutableArray *FCarrayselectdata;
    
}
@property(nonatomic,strong)NSString *FCjoinmemberids;
@property(nonatomic,strong)NSString *FCmettingid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
