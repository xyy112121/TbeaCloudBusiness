//
//  ComMettingDetailLookViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//
/**0302-01-公司人员-水电工会议-会议结束前查看会议(更新前)   即当用户发起起会议后点击查看后跳转的页面**/
#import <UIKit/UIKit.h>

@interface ComMettingDetailLookViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    NSDictionary *FCdicdata;
    NSArray *FCarrayjibandanwei;
    NSString *FCmettingarrangement;
    NSString *FCjoinmemberids;
}
@property(nonatomic,strong)NSString *FCfromflag;//是从列表来的还是从发起会议过来的   1表示列表过来的  2表示发起会议过来的
@property(nonatomic,strong)NSString *FCmettingid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;


@end
