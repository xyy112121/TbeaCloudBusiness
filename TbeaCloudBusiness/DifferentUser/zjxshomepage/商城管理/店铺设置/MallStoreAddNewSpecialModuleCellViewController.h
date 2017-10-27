//
//  MallStoreAddNewSpecialModuleCellViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/9/3.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/*添加规格型号  这里分开两个种类*/

#import <UIKit/UIKit.h>

@interface MallStoreAddNewSpecialModuleCellViewController : UIViewController<DateTimePickerViewDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *tableview;
    AppDelegate *app;
    
    UITextField *textfield;
    
    NSString *FCspecialname;
    NSString *FCmodulename;
}
@property(nonatomic,strong)NSString *FCstarttime;
@property(nonatomic,strong)NSString *FCendtime;
@property (nonatomic, strong) DateTimePickerView *datePickerView;
@property(nonatomic,strong)id<ActionDelegate>delegate1;


@end
