//
//  MallStoreCycleAdDetailViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/13.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**轮换广告  详情 编辑，修改**/

#import <UIKit/UIKit.h>

@interface MallStoreCycleAdDetailViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    AppDelegate *app;
    UITableView *tableview;
    UIImage *FCimage;
    UIImageView *FCadimageview;
    
    NSDictionary *FCselectdic; //链接 页面的dic
    
    
    NSString *FCtitle;
    NSString *FCurltype;
    NSString *FCurl;
    NSString *FCuploadstrpic;
    
    
}
@property(nonatomic,strong)NSString *FCadvertiseid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@end
