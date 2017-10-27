//
//  WaterPersonCellView.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/29.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/*
 WaterPersonMangerViewController  
 水电工管理中用到的cell
 */

#import <UIKit/UIKit.h>

@interface WaterPersonCellView : UIView
{
	AppDelegate *app;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom  UserType:(NSString *)usertype;

@end
