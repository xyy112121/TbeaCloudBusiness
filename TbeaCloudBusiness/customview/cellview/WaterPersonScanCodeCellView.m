//
//  WaterPersonScanCodeCellView.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/1.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "WaterPersonScanCodeCellView.h"

@implementation WaterPersonScanCodeCellView

-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom  Type:(EnWaterScanTianType)type
{
	self = [super initWithFrame:frame];
	if(self)
	{
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		self.backgroundColor = [UIColor whiteColor];
		if(type==EnWaterTiXianType)
		{
			[self initvieTiXian:dicfrom];
		}
		else if(type==EnWaterScanType)
		{
			[self initviescan:dicfrom];
		}
		
		
	}
	return self;
}

-(void)initviescan:(NSDictionary *)dicfrom
{
	float widthnow = (SCREEN_WIDTH-20)/3;
	NSString *strtiem = [dicfrom objectForKey:@"scantime"];
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, widthnow+20, 20)];
	labeltime.text = strtiem;
	labeltime.textColor = [UIColor blackColor];
	labeltime.font = FONTN(13.0f);
	labeltime.textAlignment = NSTextAlignmentCenter;
	[self addSubview:labeltime];
	
	
	UILabel *labelnumber = [[UILabel alloc] initWithFrame:CGRectMake(10+widthnow+10, 15, widthnow, 20)];
	labelnumber.text = [dicfrom objectForKey:@"confirmstatus"];
	if([labelnumber.text isEqualToString:@"已确认"])
	{
		labelnumber.textColor = COLORNOW(0, 170, 236);
	}
	else
		labelnumber.textColor = [UIColor blackColor];
	labelnumber.font = FONTN(13.0f);
	labelnumber.textAlignment = NSTextAlignmentCenter;
	[self addSubview:labelnumber];
	
    CGSize size = [AddInterface getlablesize:[NSString stringWithFormat:@"%@",[dicfrom objectForKey:@"money"]] Fwidth:widthnow Fheight:20 Sfont:FONTMEDIUM(14.0f)];
	UILabel *labeljihuo = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-size.width, 15, size.width, size.height)];
	labeljihuo.text = [NSString stringWithFormat:@"%@",[dicfrom objectForKey:@"money"]];
	labeljihuo.textColor = [UIColor blackColor];
	labeljihuo.font = FONTMEDIUM(14.0f);
	labeljihuo.textAlignment = NSTextAlignmentRight;
	[self addSubview:labeljihuo];
    
    UILabel *lablemoneyflag1 = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labeljihuo)-11, XYViewTop(labeljihuo)+4, 10,10)];
    lablemoneyflag1.text = @"￥";
    lablemoneyflag1.font = FONTMEDIUM(10.0f);
    lablemoneyflag1.textColor = [UIColor blackColor];
    lablemoneyflag1.backgroundColor = [UIColor clearColor];
    [self addSubview:lablemoneyflag1];
}

-(void)initvieTiXian:(NSDictionary *)dicfrom
{
	float widthnow = (SCREEN_WIDTH-20)/3;
	NSString *strtiem = [dicfrom objectForKey:@"time"];
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, widthnow+20, 20)];
	labeltime.text = strtiem;;
	labeltime.textColor = [UIColor blackColor];
	labeltime.font = FONTN(13.0f);
	labeltime.textAlignment = NSTextAlignmentLeft;
	[self addSubview:labeltime];
	
    UILabel *labelnumber = [[UILabel alloc] initWithFrame:CGRectMake(10+widthnow+10, 15, widthnow, 20)];
    labelnumber.text = [dicfrom objectForKey:@"zone"];
    labelnumber.textColor = [UIColor blackColor];
    labelnumber.font = FONTN(13.0f);
    labelnumber.textAlignment = NSTextAlignmentCenter;
    [self addSubview:labelnumber];
    
    CGSize size = [AddInterface getlablesize:[NSString stringWithFormat:@"%@",[dicfrom objectForKey:@"money"]] Fwidth:widthnow Fheight:20 Sfont:FONTMEDIUM(14.0f)];
    UILabel *labeljihuo = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-size.width, 15, size.width, size.height)];
    labeljihuo.text = [NSString stringWithFormat:@"%@",[dicfrom objectForKey:@"money"]];
    labeljihuo.textColor = [UIColor blackColor];
    labeljihuo.font = FONTMEDIUM(14.0f);
    labeljihuo.textAlignment = NSTextAlignmentRight;
    [self addSubview:labeljihuo];
    
    UILabel *lablemoneyflag1 = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labeljihuo)-11, XYViewTop(labeljihuo)+4, 10,10)];
    lablemoneyflag1.text = @"￥";
    lablemoneyflag1.font = FONTMEDIUM(10.0f);
    lablemoneyflag1.textColor = [UIColor blackColor];
    lablemoneyflag1.backgroundColor = [UIColor clearColor];
    [self addSubview:lablemoneyflag1];
}

@end
