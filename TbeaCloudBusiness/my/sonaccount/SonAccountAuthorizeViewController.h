//
//  SonAccountAuthorizeViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/17.
//  Copyright © 2017年 谢 毅. All rights reserved.
//
/**字账户功能授权**/

#import <UIKit/UIKit.h>

@interface SonAccountAuthorizeViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    NSArray *FCarrayitemlist;
    
}
@property(nonatomic,strong)NSMutableArray *FCarrayauthor;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
