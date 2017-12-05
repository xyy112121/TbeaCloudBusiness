//
//  AddCustomView.h
//  TbeaGuardian
//
//  Created by xyy on 2017/9/11.
//  Copyright © 2017年 xyy. All rights reserved.
//
/*公共的view*/
#import <Foundation/Foundation.h>

@interface AddCustomView : NSObject

/*公共的线，传入颜色和大小返回一条颜色带*/
+(UIImageView *)CusViewLine:(CGRect)frame BGColor:(UIColor*)bgcolor;

/*公共的imageview 传图片大小与图片*/
+(UIImageView *)CusViewImageView:(CGRect)frame Image:(UIImage *)image;

/*带圆角的imageview*/
+(UIImageView *)CusViewImageViewForRadius:(CGRect)frame Image:(UIImage *)image FRadius:(float)fradius;

/*公共的button,透明button*/
+(UIButton *)CusViewButton:(CGRect)frame;

/*公共的button 对button有样式控制 */
+(UIButton *)CusViewButtonForRadius:(CGRect)frame BGColor:(UIColor *)bgcolor Title:(NSString *)title TitleColor:(UIColor *)tcolor FRadius:(float)fradius;

/*公共的label */
+(UILabel *)CusViewLabel:(CGRect)frame BGColor:(UIColor *)color;

/*公共带信息的label*/
+(UILabel *)CusViewLabelTitle:(CGRect)frame BGColor:(UIColor *)bgcolor Title:(NSString *)title TitleColor:(UIColor *)titlecolor;

/*公共的label 传入颜色字体大小及显示的字*/
+(UILabel *)CusViewLabelForStyle:(CGRect)frame BGColor:(UIColor *)bgcolor Title:(NSString *)title TColor:(UIColor *)tcolor Font:(UIFont *)font LineNumber:(int)linenumber;

@end
