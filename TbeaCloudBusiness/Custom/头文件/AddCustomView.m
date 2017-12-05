//
//  AddCustomView.m
//  TbeaGuardian
//
//  Created by xyy on 2017/9/11.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "AddCustomView.h"

@implementation AddCustomView


+(UIImageView *)CusViewLine:(CGRect)frame BGColor:(UIColor*)bgcolor
{
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:frame];
    imageline.backgroundColor = bgcolor;
    return imageline;
}

+(UIImageView *)CusViewImageView:(CGRect)frame Image:(UIImage *)image
{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:frame];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    imageview.image = image;
    return imageview;
}

+(UIImageView *)CusViewImageViewForRadius:(CGRect)frame Image:(UIImage *)image FRadius:(float)fradius
{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:frame];
    imageview.layer.cornerRadius = fradius;
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    imageview.image = image;
    return imageview;
}

+(UIButton *)CusViewButton:(CGRect)frame 
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
    return button;
}

+(UIButton *)CusViewButtonForRadius:(CGRect)frame BGColor:(UIColor *)bgcolor Title:(NSString *)title TitleColor:(UIColor *)tcolor FRadius:(float)fradius
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.layer.cornerRadius = fradius;
    button.backgroundColor = bgcolor;
    button.clipsToBounds = YES;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:tcolor forState:UIControlStateNormal];
    button.titleLabel.font = FONTN(15.0f);
    
    return button;
}


+(UILabel *)CusViewLabel:(CGRect)frame BGColor:(UIColor *)bgcolor
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = bgcolor;
    
    
    return label;
}

+(UILabel *)CusViewLabelTitle:(CGRect)frame BGColor:(UIColor *)bgcolor Title:(NSString *)title TitleColor:(UIColor *)titlecolor
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = bgcolor;
    label.font = FONTN(16.0f);
    label.text = title;
    label.textColor = titlecolor;
    return label;
}

+(UILabel *)CusViewLabelForStyle:(CGRect)frame BGColor:(UIColor *)bgcolor Title:(NSString *)title TColor:(UIColor *)tcolor Font:(UIFont *)font LineNumber:(int)linenumber
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = bgcolor;
    label.textColor = tcolor;
    label.numberOfLines = linenumber;
    label.font = font;
    label.text = title;
    
    return label;
}


@end
