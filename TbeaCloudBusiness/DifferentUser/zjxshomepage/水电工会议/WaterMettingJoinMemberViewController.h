//
//  WaterMettingJoinMemberViewController.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/5.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0302-总经销-水电工会议-会议详情-参与人员
 **/

#import <UIKit/UIKit.h>

@interface WaterMettingJoinMemberViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	UITableView *tableview;
	AppDelegate *app;
    
    NSArray *FCarraydata;
	
}
@property(nonatomic,strong)NSString *FCmettingid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
