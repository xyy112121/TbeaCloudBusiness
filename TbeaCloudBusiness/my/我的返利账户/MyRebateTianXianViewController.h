//
//  MyRebateTianXianViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/16.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRebateTianXianViewController : UIViewController<UIPickerViewDelegate,ActionDelegate>
{
    AppDelegate *app;
    NSDictionary *dicmymoney;
    
    UIView *maskView;
    NSString *result1;
    NSMutableArray *content1;
    NSArray *arrayjxsdata;
    NSDictionary *dicselectaddr;
    NSString *selectdistribuid;
}



@end
