//
//  WaterPersonHpInfoViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/6.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/*个人页面，本页面显示个人介绍 ，服务范围等，通过右上角的管理进入waterpersonhpviewcontroller*/

#import <UIKit/UIKit.h>

@interface WaterPersonHpInfoViewController : UIViewController<ActionDelegate>
{
    
    AppDelegate *app;
    EnWaterPersonHpFunctionType functiontype;
    NSDictionary *FCdicdata;
}

@property(nonatomic,strong)NSString *FCelectricianid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
