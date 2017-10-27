//
//  CreateQRCodeViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/23.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0201-返利二维码生成-
 **/

#import <UIKit/UIKit.h>

@interface CreateQRCodeViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
	UITableView *tableview;
	AppDelegate *app;
	
	NSString *strmodelid; //规格
	NSString *strspecificationid;//型号
    NSString *FCcommityName;
    NSString *FCcommityNameId;
}

@end
