//
//  MyTiXianQRCodeViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/17.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTiXianQRCodeViewController : UIViewController
{
    AppDelegate *app;
    NSDictionary *dicmytixian;
    NSTimer *timertixian;
}
@property(nonatomic,strong)NSString *strdistribuid;
@property(nonatomic,strong)NSString *tixianmoney;
@end
