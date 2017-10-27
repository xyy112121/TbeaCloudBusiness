//
//  ScanQRInputCodeViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanQRInputCodeViewController : UIViewController<ActionDelegate,UITextFieldDelegate>
{
    AppDelegate *app;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
