//
//  ComMettingDetailUploadViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/14.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/*会议更新  点击更新进入此页面 再进入具体的更新页面*/

#import <UIKit/UIKit.h>

@interface ComMettingDetailUploadViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *tableview;
    AppDelegate *app;
    NSString *FCdetailsummary;
    NSString *FCPicNumber;
    
}
@property(nonatomic,strong)NSString *FCmettingid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
