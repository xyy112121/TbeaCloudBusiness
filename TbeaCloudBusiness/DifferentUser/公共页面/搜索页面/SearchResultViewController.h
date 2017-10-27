//
//  SearchResultViewController.h
//  TbeaWaterElectrician
//
//  Created by xyy520 on 17/2/6.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,ActionDelegate>
{
	AppDelegate *app;
	NSMutableArray *arraydata;
	UITableView *tableview;
    NSArray *FCarraydata;
}

@property(nonatomic,strong)NSString *FCsearchkeyword;
@property(nonatomic,strong)NSString *FCSearchFromType;
@end
