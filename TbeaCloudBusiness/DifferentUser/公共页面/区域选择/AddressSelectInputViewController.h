//
//  AddressSelectInputViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/4.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**地址选择，包括省市 具体地址填写**/

#import <UIKit/UIKit.h>

@interface AddressSelectInputViewController : UIViewController<FDCityPickerDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *tableview;
    AppDelegate *app;
    
    EnSelectTime enselecttime; 
}
@property (nonatomic, strong)NSString *FCprovice;
@property (nonatomic, strong)NSString *FCcity;
@property (nonatomic, strong)NSString *FCarea;
@property (nonatomic, strong)NSString *FCspecificaddress; //区以下的地址
@property (nonatomic, strong) DateTimePickerView *datePickerView;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
