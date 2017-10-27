//
//  scanrebatehpcellview.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/21.
//  Copyright © 2017年 谢 毅. All rights reserved.
//


/**
 本类用于扫码返利的主页面 ScanRebatehpViewController
 
 **/
#import <UIKit/UIKit.h>

@interface ScanRebatehpCellview : UIView
{
	AppDelegate *app;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom  CellIndex:(NSIndexPath *)indexPath;
@end
