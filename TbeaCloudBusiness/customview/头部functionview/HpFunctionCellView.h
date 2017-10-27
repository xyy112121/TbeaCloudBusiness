//
//  HpFunctionCellView.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/27.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**主页下部横条菜单栏**/

#import <UIKit/UIKit.h>

@interface HpFunctionCellView : UIView
{
	AppDelegate *app;
    NSDictionary *FCdicdata;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame celltype:(EnHpFunctionCellType)type Dic:(NSDictionary *)dic IndexPath:(NSIndexPath *)indexpath;
@end
