//
//  MallStoreAddNewGoodsViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/28.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MallStoreAddNewGoodsViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate,UITextViewDelegate>
{
    UITableView *tableview;
    AppDelegate *app;
    
    NSString *FCCommodityId;
    NSString *FCName;
    NSString *FCCategoryId;
    NSString *FCCategoryName;
    NSString *FCModelId;
//    NSString *FCModelName;
    NSString *FCspecialid;
    NSString *FCspecialmodelname;
    NSString *FCPrice;
    NSString *FCDiscountMoney;
    NSString *FCUnit;
    NSString *FCStockNumber;
    NSString *FCDescription;
    NSString *FCThumbList;
    NSString *FCPictureList;
    NSString *FCRecommended;
    
    
    VBTextView *FCtextviewdes;
    UIButton *FCtuijianBT;
    
    NSArray *FCarrayspecifi; //型号规格
    NSArray *FCarraymodelselect; //
    NSArray *FCarraycategory;
    
    NSArray *FCarraythumbimage;
    NSArray *FCarraypictureimage;
    
    UIScrollView *FCthumbscrollview;
    UIScrollView *FCdetailscrollview;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
