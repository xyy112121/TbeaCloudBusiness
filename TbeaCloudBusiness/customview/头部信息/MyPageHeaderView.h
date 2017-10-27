//
//  MyPageHeaderView.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/16.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0000-我的-总经销商
 **/

#import <UIKit/UIKit.h>

@interface MyPageHeaderView : UIView
{
	AppDelegate *app;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom;
@end
