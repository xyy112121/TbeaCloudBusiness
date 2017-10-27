//
//  MallStoreFuntionView.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/7/7.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MallStoreFuntionView.h"

@implementation MallStoreFuntionView

-(id)initWithFrame:(CGRect)frame ArrayFunction:(NSArray *)arrayfunction
{
	self = [super initWithFrame:frame];
	if(self)
	{
		
		arrayfromfunction = arrayfunction;
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		self.backgroundColor = [UIColor clearColor];
        [self initview:arrayfunction];
	}
	return self;
}

-(void)initview:(NSArray *)arrayfunction  //总经销商
{
    UIImageView *imageviewbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, XYViewHeight(self)-10)];
    imageviewbg.backgroundColor = [UIColor whiteColor];
    [self addSubview:imageviewbg];
    
	float widthspace = 40;//左右的距离
	float widthbt = 30;// 每个image的宽度
	float heightbt = 30;//   每个image的高度
	float widthnow = (SCREEN_WIDTH-widthbt*4-widthspace*2)/3;
	
	int counth = 0;
	int countv = 0;
	int countspecifi = 4;//(int)[arrayfunction count];
	counth = (countspecifi%4==0?countspecifi/4:countspecifi/4+1);
	
	
	for(int i=0;i<counth;i++)
	{
		if(i<counth-1)
		{
			countv = 4;
		}
		else
		{
			countv = countspecifi%4==0?4:countspecifi%4;
		}
		
		for(int j=0;j<countv;j++)
		{
			NSDictionary *dictemp = [arrayfunction objectAtIndex:i*4+j];
			NSString *strpic;
			NSString *strtitle;
			
			
            strpic = [dictemp objectForKey:@"moduleicon"];//[InterfaceResource stringByAppendingString:[dictemp objectForKey:@"moduleicon"]];
			strtitle = [dictemp objectForKey:@"modulename"];
			
			UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(widthspace+(widthbt+widthnow)*j, 20+(heightbt+50)*i, widthbt, heightbt)];
			[imageview setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"hp考勤管理", @"png")];
			[self addSubview:imageview];
			
			UIButton *button = [self initbutton:strpic Title:strtitle BtFrame:CGRectMake(XYViewL(imageview)-10,XYViewTop(imageview),XYViewWidth(imageview)+20,XYViewHeight(imageview)+30)];
			button.tag = EnMallStoreFunctionButtonTag+i*4+j;
			[button addTarget:self action:@selector(clickappfunction:) forControlEvents:UIControlEventTouchUpInside];
			[self addSubview:button];
			
			UILabel *lable = [self initlabel:strtitle BtFrame:CGRectMake(imageview.frame.origin.x-30, XYViewBottom(imageview)+5, widthbt+60, 20)];
			[self addSubview:lable];
		}
	}
}

-(UIButton *)initbutton:(NSString *)strimage Title:(NSString *)title BtFrame:(CGRect)btframe
{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = btframe;
	button.backgroundColor = [UIColor clearColor];
	[button setImageEdgeInsets:UIEdgeInsetsMake(-20, 0, 0, 0)];
	
	return button;
}

-(UILabel *)initlabel:(NSString *)title BtFrame:(CGRect)btframe
{
	UILabel *lable = [[UILabel alloc] initWithFrame:btframe];
	lable.text = title;
	lable.font = FONTN(14.0f);
	lable.textColor = COLORNOW(117, 117, 117);
	lable.backgroundColor = [UIColor clearColor];
	lable.textAlignment = NSTextAlignmentCenter;
	return lable;
}

-(void)clickappfunction:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag]-EnMallStoreFunctionButtonTag;
	
	
	
//	顶替
	
	if([self.delegate1 respondsToSelector:@selector(DGClickMallStoreFunctionGotoView:)])
	{
		NSDictionary *dictemp = [arrayfromfunction objectAtIndex:tagnow];
		[self.delegate1 DGClickMallStoreFunctionGotoView:dictemp];
	}
	
	
}

@end
