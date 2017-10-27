//
//  TbeaHpCellView.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/13.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TbeaHpCellView : UIView
{
	AppDelegate *app;
	NSDictionary *dicsrc;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame ArrayFrom:(NSArray *)dicfrom;
-(id)initWithFrameProduct:(CGRect)frame DicFrom:(NSDictionary *)dicfrom;

@end
