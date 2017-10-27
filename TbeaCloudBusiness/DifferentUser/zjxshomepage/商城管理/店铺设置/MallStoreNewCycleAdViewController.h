//
//  MallStoreNewCycleAdViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/28.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**轮换广告  添加**/
#import <UIKit/UIKit.h>

@interface MallStoreNewCycleAdViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    AppDelegate *app;
    UITableView *tableview;
    UIImage *FCimage;
    UIImageView *FCadimageview;
    
    NSDictionary *FCselectdic; //链接 页面的dic
    
    NSString *FCadvertiseid;
    NSString *FCtitle;
    NSString *FCurltype;
    NSString *FCurl;
    NSString *FCuploadstrpic;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;


@end
