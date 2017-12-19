//
//  ShangJiaZiLiaoViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/12/19.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShangJiaZiLiaoViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *tableview;
    AppDelegate *app;
    NSDictionary *FCdistributorinfo;
    
    UIImageView *FCimageheader;
    
    
}
@property(nonatomic,strong)NSString *FCdistributorid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
