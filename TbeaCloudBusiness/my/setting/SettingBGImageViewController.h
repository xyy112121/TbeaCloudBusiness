//
//  SettingBGImageViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/17.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingBGImageViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIImageView *imageview;
    AppDelegate *app;
    NSString *FCstrimagebg;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
