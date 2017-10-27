//
//  PopCustomDoneView.h
//  TbeaCloudBusiness
//
//  Created by 谢毅 on 2017/10/24.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopCustomDoneView : UIView
{
    AppDelegate *app;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(instancetype)initWithFrame:(CGRect)frame strFrom:(NSString *)str BtTitle:(NSString *)bttitle;
@end
