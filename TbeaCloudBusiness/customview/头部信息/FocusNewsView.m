//
//  FocusNewsView.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/2/20.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "FocusNewsView.h"

@implementation FocusNewsView

-(id)initWithFrame:(CGRect)frame Focus:(NSArray *)focus
{
	self = [super initWithFrame:frame];
	if (self)
	{
		arrayfocus = focus;
		[self initviewloop:arrayfocus];
	}
	return self;
}

-(void)initviewloop:(NSArray *)focus
{
	float nowheight = 180;
//	if(iphone6)
//		nowheight = nowheight*iphone6ratio;
//	else if(iphone6p)
//		nowheight = nowheight*iphone6pratio;
	
	
	self.backgroundColor = [UIColor clearColor];

	NSMutableArray *arraypiclist =  [[NSMutableArray alloc] init];
	for(int i=0;i<[arrayfocus count];i++)
	{
		NSDictionary *dictemp = [arrayfocus objectAtIndex:i];
        NSString *strpic = [dictemp objectForKey:@"picture"];
        [arraypiclist addObject:[strpic length]>0?strpic:@"123"];
	}
	
	self.loop = [[XLsn0wLoop alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, nowheight)];
	[self addSubview:self.loop];
	self.loop.xlsn0wDelegate = self;
	self.loop.time = 5;
	[self.loop setPagePosition:PositionBottomCenter];
	[self.loop setPageColor:Colorredcolor andCurrentPageColor:[UIColor whiteColor]];
	//支持gif动态图
	self.loop.imageArray = arraypiclist;
	

	[self addfourbutton:CGRectMake(0, XYViewBottom(self.loop), SCREEN_WIDTH, 75)];
	
}

-(void)addfourbutton:(CGRect)frame
{
	UIView*viewtop = [[UIView alloc] initWithFrame:frame];
	viewtop.backgroundColor = [UIColor whiteColor];
	[self addSubview:viewtop];
	
	float nowwidth = ((SCREEN_WIDTH-40)-4*60)/3;
	UIView *view;
	for(int i=0;i<4;i++)
	{
		switch (i)
		{
			case 0:
				view =[self initbutton:CGRectMake(20+(60+nowwidth)*i,0, 60, 80) Image:LOADIMAGE(@"tbeacominstroduce", @"png") Title:@"公司简介" TagSet:i];
				break;
			case 1:
				view =[self initbutton:CGRectMake(20+(60+nowwidth)*i,0, 60, 80) Image:LOADIMAGE(@"tbeanews", @"png") Title:@"新闻资讯" TagSet:i];
				break;
			case 2:
				view =[self initbutton:CGRectMake(20+(60+nowwidth)*i,0, 60, 80) Image:LOADIMAGE(@"tbeaproduct", @"png") Title:@"产品介绍" TagSet:i];
				break;
			case 3:
				view =[self initbutton:CGRectMake(20+(60+nowwidth)*i,0, 60, 80) Image:LOADIMAGE(@"tbeacontact", @"png") Title:@"联系方式" TagSet:i];
				break;
		}
		[viewtop addSubview:view];
	}
}

-(UIView *)initbutton:(CGRect)frame Image:(UIImage *)image Title:(NSString *)title TagSet:(int)tagset
{
	UIView *view = [[UIView alloc] initWithFrame:frame];
	view.backgroundColor = [UIColor clearColor];
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake((XYViewWidth(view)-30)/2,10, 30, 30)];
	imageview.image = image;
	[view addSubview:imageview];
	
	UILabel *labtitle = [[UILabel alloc] initWithFrame:CGRectMake(0,XYViewBottom(imageview)+5, XYViewWidth(view), 20)];
	labtitle.text = title;
	labtitle.font = FONTN(14.0f);
	labtitle.textColor = COLORNOW(117, 117, 117);
	labtitle.textAlignment = NSTextAlignmentCenter;
	[view addSubview:labtitle];
	
	UIButton *buttontop = [UIButton buttonWithType:UIButtonTypeCustom];
	buttontop.frame = CGRectMake(5, 5, XYViewWidth(view)-10,XYViewHeight(view)-15);
	buttontop.backgroundColor = [UIColor clearColor];
	buttontop.tag = EnFocusFunctionButton+tagset;
	[buttontop addTarget:self action:@selector(clicktopbutton:) forControlEvents:UIControlEventTouchUpInside];
	[view addSubview:buttontop];
	
	return view;
}

#pragma mark XRCarouselViewDelegate
- (void)loopView:(XLsn0wLoop *)loopView clickImageAtIndex:(NSInteger)index {
	NSLog(@"点击了第%ld张图片", index);
	
	if([self.delegate1 respondsToSelector:@selector(DGFocusClickNumberPic:)])
	{
	//	NSArray *focus = [dicfocus objectForKey:@"list"];
		[self.delegate1 DGFocusClickNumberPic:@""];
	}
}

-(void)DGClickTopFunction:(id)sender
{
}

-(void)clicktopbutton:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag]-EnFocusFunctionButton;
	if([self.delegate1 respondsToSelector:@selector(DGClickTopFunction:)])
	{
		[self.delegate1 DGClickTopFunction:tagnow];
	}
}

//-(void)changepicdescript:(int)currentindex
//{
//	NSArray *arrayfocus = [dicfocus objectForKey:@"list"];
//	NSDictionary *dictemp = [arrayfocus objectAtIndex:currentindex];
//	UILabel *labeltitle = [self viewWithTag:EnFocusTitleLabelTag];
//	labeltitle.text = [dictemp objectForKey:@"title"];
//}

-(void)photoTappedAd:(UIGestureRecognizer*)sender
{
//	int tagnow = (int)[[sender view] tag];
}


@end
