//
//  WaterPersonCellView.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/29.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "WaterPersonCellView.h"

@implementation WaterPersonCellView

-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom  UserType:(NSString *)usertype
{
	self = [super initWithFrame:frame];
	if(self)
	{
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		self.backgroundColor = [UIColor whiteColor];
		[self initviewwater:dicfrom];

	}
	return self;
}

//水电工cell
-(void)initviewwater:(NSDictionary *)dic
{
	float nowwidth = (SCREEN_WIDTH-40)/4;
	
	UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
    NSString *strpic = [dic objectForKey:@"thumbpicture"];//[InterfaceResource stringByAppendingString:[[dic objectForKey:@"thumbpicture"] length]>0?[dic objectForKey:@"thumbpicture"]:@"noimage.png"];
	[imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
	[self addSubview:imageheader];
	
	NSString *strname = [dic objectForKey:@"personname"];
	CGSize size = [AddInterface getlablesize:strname Fwidth:200 Fheight:20 Sfont:FONTN(14.0f)];
	UILabel *lablename = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewTop(imageheader)+10, size.width, 20)];
	lablename.text =strname;
	lablename.font = FONTN(14.0f);
	lablename.textColor = [UIColor blackColor];
	lablename.backgroundColor = [UIColor clearColor];
	[self addSubview:lablename];
	
	UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(lablename)+5, XYViewTop(lablename)+5, 10, 10)];
	imageicon.image = LOADIMAGE(@"scanrebateheader1", @"png");
	[self addSubview:imageicon];
	
	UILabel *lablearea = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+10, 20, nowwidth, 20)];
	lablearea.text = [dic objectForKey:@"cityzone"];
	lablearea.font = FONTN(14.0f);
	lablearea.textColor = [UIColor blackColor];
	lablearea.backgroundColor = [UIColor clearColor];
	[self addSubview:lablearea];
	
	
	
	NSString *strmoney = [NSString stringWithFormat:@"%@",[dic objectForKey:@"totlemoney"]];
	size = [AddInterface getlablesize:strmoney Fwidth:nowwidth Fheight:20 Sfont:FONTMEDIUM(15.0f)];
	UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-size.width-10, 20, size.width, 20)];
	lablemoneyvalue.text = strmoney;
	lablemoneyvalue.font = FONTMEDIUM(15.0f);
	lablemoneyvalue.textColor = [UIColor blackColor];
	lablemoneyvalue.backgroundColor = [UIColor clearColor];
	[self addSubview:lablemoneyvalue];
	
	UILabel *lablemoneyflag = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablemoneyvalue)-11, 20+4, 10,10)];
	lablemoneyflag.text = @"￥";
	lablemoneyflag.font = FONTMEDIUM(11.0f);
	lablemoneyflag.textColor = [UIColor blackColor];
	lablemoneyflag.backgroundColor = [UIColor clearColor];
	[self addSubview:lablemoneyflag];
	
}

@end
