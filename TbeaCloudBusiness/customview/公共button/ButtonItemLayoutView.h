//
//  ButtonItemLayoutView.h
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonItemLayoutView : UIView
{
	AppDelegate *app;
}
@property(nonatomic,strong)UIButton *buttoncustom;
@property(nonatomic,strong)UILabel *labelname;
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UIImageView *imageviewicon;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

-(void)updateimage:(UIImage *)image;
-(void)updatelablecolor:(UIColor *)color;
-(void)updatebuttonitem:(EnButtonTextAlignment)textalignment TextStr:(NSString *)textstr  Font:(UIFont *)font Color:(UIColor *)color Image:(UIImage *)image;
-(void)updatelabstr:(NSString *)textstr;
@end
