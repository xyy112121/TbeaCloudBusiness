//
//  AlertViewExtension.m
//  AlertView
//
//  Created by alive on 2017/2/4.
//  Copyright © 2017年 刘学丽. All rights reserved.
//

#import "AlertViewExtension.h"

@implementation AlertViewExtension

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        //设置模板层背景色
        self.backgroundColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:0.7];
        
        _tipebackView =[[UIView alloc]initWithFrame:CGRectMake(30, (self.frame.size.height-150)/2, self.frame.size.width-60, frame.size.height)];
        _tipebackView.backgroundColor=[UIColor whiteColor];
        _tipebackView.layer.cornerRadius=5;
        [self addSubview:_tipebackView];
		
		_imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 20, 20)];
		_imageicon.image = [UIImage imageNamed:@"useralert.png"];
		_imageicon.backgroundColor = [UIColor clearColor];
		[_tipebackView addSubview:_imageicon];
		
		
		_tipeLabeltitle =[[UILabel alloc]initWithFrame:CGRectMake(_imageicon.frame.origin.x+_imageicon.frame.size.width+5, 10, _tipebackView.frame.size.width-40, 20)];
		_tipeLabeltitle.textColor = [UIColor blackColor];
		_tipeLabeltitle.text = @"这个是弹框标题";
		_tipeLabeltitle.font =  [UIFont fontWithName:@"STHeitiTC-Medium" size:15.0f];
		[_tipebackView addSubview:_tipeLabeltitle];
		
		UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(20, 40, _tipebackView.frame.size.width-40, 0.7)];
		imageline.backgroundColor = [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1];
		[_tipebackView addSubview:imageline];
		
        _tipeLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, 60, _tipebackView.frame.size.width-40, _tipebackView.frame.size.height-110)];
		_tipeLabel.backgroundColor = [UIColor clearColor];
        _tipeLabel.numberOfLines= 0;
        [_tipebackView addSubview:_tipeLabel];
		
        _sureBtn  =[UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.tag=1920;
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureBtn.titleLabel.font =[UIFont systemFontOfSize:16 weight:0.5];
		_sureBtn.layer.cornerRadius = 3.0f;
		_sureBtn.clipsToBounds = YES;
        [_sureBtn addTarget:self action:@selector(btnClickSelector:) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.backgroundColor=[UIColor colorWithRed:254/255.0 green:72/255.0 blue:68/255.0 alpha:1.0];
        [_tipebackView addSubview:_sureBtn];
    }
    return self;
}

//设置提示view的宽高
-(void)setbackviewframeWidth:(CGFloat)width Andheight:(CGFloat)height
{
    CGFloat tipeheight =(self.frame.size.height-height)/2;
    CGFloat tipewidth=(self.frame.size.width-width)/2;
    _tipebackView.frame=CGRectMake(tipewidth, tipeheight, width, height);
    _tipeLabel.frame=CGRectMake(20, 50, _tipebackView.frame.size.width-40, _tipebackView.frame.size.height-110);
//    _cancelBtn.frame=CGRectMake(0, _tipebackView.frame.size.height-45, width/2, 45);
    _sureBtn.frame=CGRectMake(20, _tipebackView.frame.size.height-50, _tipebackView.frame.size.width-40, 40);
}
//设置提示语
-(void)settipeTitleStr:(NSString *)tipeStr Andfont:(CGFloat)font Title:(NSString *)title BtStr:(NSString *)btstr
{
    _tipeLabel.font=[UIFont systemFontOfSize:font];
    _tipeLabel.text=tipeStr;
	_tipeLabeltitle.text = title;
	[_sureBtn setTitle:btstr forState:UIControlStateNormal];
    
    
}

//按钮方法
-(void)btnClickSelector:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(clickBtnSelector:)]) {
        [self.delegate clickBtnSelector:btn];
    }
}
@end
