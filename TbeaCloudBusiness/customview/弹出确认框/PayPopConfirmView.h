//
//  PayPopConfirmView.h
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/7/11.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayPopConfirmView : UIView
{
    AppDelegate *app;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(instancetype)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom;
@end
