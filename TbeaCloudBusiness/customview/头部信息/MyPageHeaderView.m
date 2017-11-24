//
//  MyPageHeaderView.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/16.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MyPageHeaderView.h"

@implementation MyPageHeaderView

-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom
{
	self = [super initWithFrame:frame];
	if(self)
	{
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		self.backgroundColor = COLORNOW(0, 170, 238);
		[self initview:dicfrom];
		
	}
	return self;
}


-(void)initview:(NSDictionary  *)dicfrom
{
	UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(20,StatusBarHeight+40,70,70)];
    NSString *strpic = [dicfrom objectForKey:@"thumbpicture"];//[NSString stringWithFormat:@"%@%@",InterfaceResource,[dicfrom objectForKey:@"thumbpicture"]];
    [imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"watertest", @"png")];
	imageheader.layer.cornerRadius = 35.f;
	imageheader.clipsToBounds = YES;
	imageheader.contentMode = UIViewContentModeScaleAspectFill;
	[self addSubview:imageheader];
	
	UILabel *lablename = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewTop(imageheader)+5, 200, 20)];
	lablename.text = [dicfrom objectForKey:@"username"];
	lablename.font = FONTMEDIUM(17.0f);
	lablename.textColor = [UIColor whiteColor];
	lablename.backgroundColor = [UIColor clearColor];
	[self addSubview:lablename];
	
	UILabel *labletype = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablename), XYViewBottom(lablename), 100, 20)];
	labletype.text = [dicfrom objectForKey:@"usertype"];
	labletype.font = FONTN(13.0f);
	labletype.textColor = COLORNOW(245, 245, 245);
	labletype.backgroundColor = [UIColor clearColor];
	[self addSubview:labletype];
	
	
	UILabel *lableaddr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labletype), XYViewBottom(labletype), 200, 20)];
	lableaddr.text = [dicfrom objectForKey:@"usercompanyname"];
	lableaddr.font = FONTN(13.0f);
	lableaddr.textColor = COLORNOW(245, 245, 245);
	lableaddr.backgroundColor = [UIColor clearColor];
	[self addSubview:lableaddr];
	
	UIButton *buttonnext = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonnext.frame = CGRectMake(SCREEN_WIDTH-50, XYViewTop(imageheader)+10, 40, 40);
	[buttonnext setImage:LOADIMAGE(@"userarrowright", @"png") forState:UIControlStateNormal];
	[buttonnext addTarget:self action:@selector(gotonext:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:buttonnext];
	
}

-(void)gotonext:(id)sender
{
	
}

@end
