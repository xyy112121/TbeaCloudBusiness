//
//  WaterPersonCellHpView.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/31.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/*
 水电工管理页面WaterPersonHpViewController中用到的cell
 */

#import <UIKit/UIKit.h>

@interface WaterPersonCellHpView : UIView
{
	AppDelegate *app;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom  Type:(EnWaterPersonHpFunctionType)type;
@end
