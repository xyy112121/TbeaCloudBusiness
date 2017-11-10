//
//  ComMettingCreateSignInViewController.h
//  TbeaCloudBusiness
//
//  Created by 谢毅 on 2017/11/9.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 生成签到码页面
 **/

#import <UIKit/UIKit.h>

@interface ComMettingCreateSignInViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    NSDictionary *FCdicdata;
    UIImageView *imageqrcode;
}
@property(nonatomic,strong)NSString *FCmettingid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
