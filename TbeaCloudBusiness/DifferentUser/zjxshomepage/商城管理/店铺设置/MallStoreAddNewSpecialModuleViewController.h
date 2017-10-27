//
//  MallStoreAddNewSpecialModuleViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/28.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**保存规格型号  规格型号都是进为个页面，分两个接口保存**/

#import <UIKit/UIKit.h>

@interface MallStoreAddNewSpecialModuleViewController : UIViewController<DateTimePickerViewDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *tableview;
    AppDelegate *app;
    
    UITextField *textfield;
    
}
@property(nonatomic,strong)NSString *FCtitle;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
