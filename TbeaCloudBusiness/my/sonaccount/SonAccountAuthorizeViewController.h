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
@property(nonatomic,strong)NSString *FCfromflag;  //1表示来自于新增子账户的功能授权   2表示修改字账户的授权
@property(nonatomic,strong)NSString *FCpersonid;//  当修改子账户权限 的时候传FCpersonid过来
@end
