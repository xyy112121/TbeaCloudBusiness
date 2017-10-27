//
//  scanrebatehpcellview.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/21.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ScanRebatehpCellview.h"

@implementation ScanRebatehpCellview

-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom CellIndex:(NSIndexPath *)indexPath
{
	self = [super initWithFrame:frame];
	if(self)
	{
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		self.backgroundColor = [UIColor whiteColor];
//		if(usertype == EnScanRebateUserWater)
//		{
//			[self initviewwater:dicfrom];
//		}
//		else
//		{
			[self initview:dicfrom CellIndex:indexPath];
//		}
	}
	return self;
}

//全部cell
-(void)initview:(NSDictionary *)dic  CellIndex:(NSIndexPath *)indexPath
{
	UIImageView *imagesorticon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 21, 18, 18)];
	if(indexPath.row == 0)
		imagesorticon.image = LOADIMAGE(@"scanrebatesort1", @"png");
	else if(indexPath.row == 1)
		imagesorticon.image = LOADIMAGE(@"scanrebatesort2", @"png");
	else if(indexPath.row == 2)
		imagesorticon.image = LOADIMAGE(@"scanrebatesort3", @"png");
	else
		imagesorticon.image = LOADIMAGE(@"scanrebatesort4", @"png");
	[self addSubview:imagesorticon];
	
	UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(imagesorticon)+10, 10, 40, 40)];
    NSString *strpic = [dic objectForKey:@"thumbpicture"];//[InterfaceResource stringByAppendingString:[[dic objectForKey:@"thumbpicture"] length]>0?[dic objectForKey:@"thumbpicture"]:@"noimage.png"];
	[imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
	[self addSubview:imageheader];
	
	NSString *strname = [dic objectForKey:@"personname"];
	CGSize size = [AddInterface getlablesize:strname Fwidth:200 Fheight:20 Sfont:FONTN(15.0f)];
	UILabel *lablename = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewTop(imageheader), size.width, 20)];
	lablename.text =strname;
	lablename.font = FONTN(15.0f);
	lablename.textColor = [UIColor blackColor];
	lablename.backgroundColor = [UIColor clearColor];
	[self addSubview:lablename];
	
//	UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(lablename)+5, XYViewTop(lablename)+5, 10, 10)];
//	imageicon.image = LOADIMAGE(@"scanrebateheader1", @"png");
//	[self addSubview:imageicon];
	
	UIImageView *imagejobicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewL(lablename), XYViewBottom(lablename)+5, 30, 10)];
    strpic = [dic objectForKey:@"personjobtitle"];//[InterfaceResource stringByAppendingString:[[dic objectForKey:@"personjobtitle"] length]>0?[dic objectForKey:@"personjobtitle"]:@"noimage.png"];
	[imagejobicon setImageWithURL:[NSURL URLWithString:strpic]];
	[self addSubview:imagejobicon];
	
//	UILabel *lableaddr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablename), XYViewBottom(lablename), SCREEN_WIDTH-180, 20)];
//	lableaddr.text =@"成都市青羊区XX街道办事处";
//	lableaddr.font = FONTN(13.0f);
//	lableaddr.textColor = COLORNOW(160, 160, 160);
//	lableaddr.backgroundColor = [UIColor clearColor];
//	[self addSubview:lableaddr];
	
	NSString *strmoney = [NSString stringWithFormat:@"%@",[dic objectForKey:@"totlemoney"]];
	size = [AddInterface getlablesize:strmoney Fwidth:150 Fheight:20 Sfont:FONTMEDIUM(16.0f)];
	UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-size.width-20, 20, size.width, 20)];
	lablemoneyvalue.text = strmoney;
	lablemoneyvalue.font = FONTMEDIUM(16.0f);
	lablemoneyvalue.textColor = [UIColor blackColor];
	lablemoneyvalue.backgroundColor = [UIColor clearColor];
	[self addSubview:lablemoneyvalue];
	
	UILabel *lablemoneyflag = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablemoneyvalue)-13, 25, 10,10)];
	lablemoneyflag.text = @"￥";
	lablemoneyflag.font = FONTMEDIUM(12.0f);
	lablemoneyflag.textColor = [UIColor blackColor];
	lablemoneyflag.backgroundColor = [UIColor clearColor];
	[self addSubview:lablemoneyflag];
	

	
}

//水电工cell
-(void)initviewwater:(NSDictionary *)pastr
{
	UIImageView *imagesorticon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 21, 18, 18)];
	imagesorticon.image = LOADIMAGE(@"scanrebatesort1", @"png");
	[self addSubview:imagesorticon];
	
	UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(imagesorticon)+10, 10, 40, 40)];
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
	
	
	UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, 20, 95, 20)];
	lablemoneyvalue.text = @"￥2140.00";
	lablemoneyvalue.font = FONTMEDIUM(17.0f);
	lablemoneyvalue.textColor = [UIColor blackColor];
	lablemoneyvalue.backgroundColor = [UIColor clearColor];
	[self addSubview:lablemoneyvalue];
}

@end
