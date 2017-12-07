//
//  CMArrangementPicView.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/12/6.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMArrangementPicView : UIView
{
    NSMutableArray *FCArraySelect;
    UIView *FCViewbg;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame ArraySelect:(NSMutableArray *)arraySelect;
@end
