//
//  RegiestPageViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/9.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 对应 的界面0200-注册
 **/

#import <UIKit/UIKit.h>

@interface RegiestPageViewController : UIViewController<UITextFieldDelegate,ActionDelegate>
{
	int getyanzhengcodeflag;
	AppDelegate *app;
	NSTimer *timerone;
    NSString *FCusertypeid;
    NSArray *FCarrayusertype;
}
@end
