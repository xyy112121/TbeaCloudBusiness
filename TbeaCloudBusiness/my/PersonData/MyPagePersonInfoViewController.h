//
//  MyPagePersonInfoViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/12/4.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPagePersonInfoViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *tableview;
    AppDelegate *app;
    NSDictionary *FCdicuserinfo;
    
    UIImageView *FCimageheader;
    
    //参数
    NSString *FCName;
    UIImage *FCUserImage;
    NSString *FCUserImagePath;
    NSString *FCUserCategory;
    NSString *FCSex;
    NSString *FCUserAge;
    NSString *FCProvice;
    NSString *FCCity;
    NSString *FCZone;
    NSString *FCUserAddr;
    NSString *FCUserTel;
    NSString *FCShopName;
    NSString *FCUseridentify;
    
}
@property(nonatomic,strong)NSString *FCelectricianid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end