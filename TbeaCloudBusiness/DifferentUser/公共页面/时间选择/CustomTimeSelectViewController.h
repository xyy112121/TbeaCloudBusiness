//
//  CustomTimeSelectViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTimeSelectViewController : UIViewController<DateTimePickerViewDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *tableview;
    AppDelegate *app;
    
    EnSelectTime enselecttime;
   
}
@property(assign)DatePickerViewMode datemode;
@property(nonatomic,strong)NSString *FCstarttime;
@property(nonatomic,strong)NSString *FCendtime;
@property (nonatomic, strong) DateTimePickerView *datePickerView;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
