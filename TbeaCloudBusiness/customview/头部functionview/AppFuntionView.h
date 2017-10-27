//
//  AppFuntionView.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/17.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppFuntionView : UIView
{
	AppDelegate *app;
	NSArray *arrayfromfunction;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame ArrayFunction:(NSArray *)arrayfunction;
@end
