//
//  SortMoreCellView.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/26.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "SortMoreCellView.h"

@implementation SortMoreCellView

-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom  UserType:(EnScanRebateHpUserType)usertype
{
	self = [super initWithFrame:frame];
	if(self)
	{
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		self.backgroundColor = [UIColor whiteColor];
//		if(usertype == EnScanRebateUserWater)
//		{
			[self initview:dicfrom];
//		}
//		else
//		{
//			[self initview:dicfrom];
//		}
	}
	return self;
}

//全部cell  //经销cell
-(void)initview:(NSDictionary *)dic
{
	float nowwidth = (SCREEN_WIDTH-20)/4;
	
	UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
    NSString *strpic = [dic objectForKey:@"thumbpicture"];//[InterfaceResource stringByAppendingString:[[dic objectForKey:@"thumbpicture"] length]>0?[dic objectForKey:@"thumbpicture"]:@"noimage.png"];
	[imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
	[self addSubview:imageheader];
	
	NSString *strname = [dic objectForKey:@"personname"];
	CGSize size = [AddInterface getlablesize:strname Fwidth:200 Fheight:20 Sfont:FONTN(14.0f)];
	UILabel *lablename = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewTop(imageheader), size.width, 20)];
	lablename.text =strname;
	lablename.font = FONTN(14.0f);
	lablename.textColor = [UIColor blackColor];
	lablename.backgroundColor = [UIColor clearColor];
	[self addSubview:lablename];
	
	UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(lablename)+5, XYViewTop(lablename)+5, 25, 10)];
    strpic = [dic objectForKey:@"persontypeicon"];//[InterfaceResource stringByAppendingString:[[dic objectForKey:@"persontypeicon"] length]>0?[dic objectForKey:@"persontypeicon"]:@"noimage.png"];
	[imageicon setImageWithURL:[NSURL URLWithString:strpic]];
	[self addSubview:imageicon];
	
	UILabel *lableaddr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablename), XYViewBottom(lablename), SCREEN_WIDTH/2-20, 20)];
	lableaddr.text = [dic objectForKey:@"companyname"];
	lableaddr.font = FONTN(12.0f);
	lableaddr.textColor = COLORNOW(160, 160, 160);
	lableaddr.backgroundColor = [UIColor clearColor];
	[self addSubview:lableaddr];
	
	UILabel *lablearea = [[UILabel alloc] initWithFrame:CGRectMake(10+nowwidth*2, 20, nowwidth, 20)];
	lablearea.text = [dic objectForKey:@"zone"];
	lablearea.font = FONTN(14.0f);
	lablearea.textColor = COLORNOW(117, 117, 117);
	lablearea.backgroundColor = [UIColor clearColor];
    lablearea.textAlignment = NSTextAlignmentCenter;
	[self addSubview:lablearea];
	
	NSString *strmoney = [NSString stringWithFormat:@"%@",[dic objectForKey:@"totlemoney"]];
	CGSize size2 = [AddInterface getlablesize:strmoney Fwidth:nowwidth Fheight:20 Sfont:FONTMEDIUM(17.0f)];
	UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-size2.width-10, 20, size2.width, 20)];
	lablemoneyvalue.text =strmoney;
	lablemoneyvalue.font = FONTMEDIUM(17.0f);
	lablemoneyvalue.textColor = [UIColor blackColor];
	lablemoneyvalue.textAlignment = NSTextAlignmentRight;
	lablemoneyvalue.backgroundColor = [UIColor clearColor];
	[self addSubview:lablemoneyvalue];
	
	UILabel *lablemoneyflag1 = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablemoneyvalue)-10, XYViewTop(lablemoneyvalue)+4, 10,10)];
	lablemoneyflag1.text = @"￥";
	lablemoneyflag1.font = FONTMEDIUM(11.0f);
	lablemoneyflag1.textColor = [UIColor blackColor];
	lablemoneyflag1.backgroundColor = [UIColor clearColor];
	[self addSubview:lablemoneyflag1];
	
}

//水电工cell
-(void)initviewwater:(NSDictionary *)pastr
{
	float nowwidth = (SCREEN_WIDTH-40)/4;
	
	UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
	imageheader.image = LOADIMAGE(@"scanrebatetest1", @"png");
	[self addSubview:imageheader];
	
	NSString *strname = @"江南小颖";
	CGSize size = [AddInterface getlablesize:strname Fwidth:200 Fheight:20 Sfont:FONTN(14.0f)];
	UILabel *lablename = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewTop(imageheader)+10, size.width, 20)];
	lablename.text =strname;
	lablename.font = FONTN(14.0f);
	lablename.textColor = COLORNOW(117, 117, 117);
	lablename.backgroundColor = [UIColor clearColor];
	[self addSubview:lablename];
	
	UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(lablename)+5, XYViewTop(lablename)+5, 10, 10)];
	imageicon.image = LOADIMAGE(@"scanrebateheader1", @"png");
	[self addSubview:imageicon];
	
	UILabel *lablearea = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+10, 20, nowwidth, 20)];
	lablearea.text = @"广安市";
	lablearea.font = FONTN(14.0f);
	lablearea.textColor = COLORNOW(117, 117, 117);
	lablearea.backgroundColor = [UIColor clearColor];
	[self addSubview:lablearea];
	
	UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-nowwidth-10, 20, nowwidth, 20)];
	lablemoneyvalue.text = @"￥2140.00";
	lablemoneyvalue.font = FONTMEDIUM(17.0f);
	lablemoneyvalue.textColor = [UIColor blackColor];
	lablemoneyvalue.backgroundColor = [UIColor clearColor];
	[self addSubview:lablemoneyvalue];
	
}

@end
