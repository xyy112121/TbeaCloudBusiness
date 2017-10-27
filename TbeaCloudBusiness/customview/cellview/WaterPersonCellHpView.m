//
//  WaterPersonCellHpView.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/31.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "WaterPersonCellHpView.h"

@implementation WaterPersonCellHpView

-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom  Type:(EnWaterPersonHpFunctionType)type
{
	self = [super initWithFrame:frame];
	if(self)
	{
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		self.backgroundColor = [UIColor whiteColor];
		[self initviewwatercell:dicfrom Type:type];
		
	}
	return self;
}

//扫码返利
-(void)initviewwatercell:(NSDictionary  *)dicfrom Type:(EnWaterPersonHpFunctionType)type
{
    NSDictionary *dicdata;
    switch (type)
    {
        case EnWaterPersonScanRebate:
            dicdata = [dicfrom objectForKey:@"rebatescaninfo"];
            break;
        case EnWaterPersonMetting:
            dicdata = [dicfrom objectForKey:@"electricianmeetingattendinfo"];
            break;
        case EnWaterPersonService:
            dicdata = [dicfrom objectForKey:@"orderingserviceinfo"];
            break;
        case EnWaterPersonOrder:
            dicdata = [dicfrom objectForKey:@"commodityorderinfo"];
            break;
        case EnWaterPersonSocialinfo:
            dicdata = [dicfrom objectForKey:@"socialinfo"];
            break;
        case EnWaterPersonLogin:
            dicdata = [dicfrom objectForKey:@"logininfo"];
            break;
            
    }
    
	UIImageView *imageviewgray = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
	imageviewgray.backgroundColor = COLORNOW(235, 235, 235);
	[self addSubview:imageviewgray];
	
	UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(20, 22, 16, 16)];
	
	[self addSubview:imageheader];
	
	UILabel *lablename = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+10, XYViewTop(imageheader)-2, 100, 20)];
	lablename.font = FONTN(15.0f);
	lablename.textColor = [UIColor blackColor];
	lablename.backgroundColor = [UIColor clearColor];
	[self addSubview:lablename];
	

	UILabel *lablename1 = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablename), XYViewBottom(lablename)+5, 100, 20)];
	
	lablename1.font = FONTN(14.0f);
	lablename1.textColor = COLORNOW(117, 117, 117);
	lablename1.backgroundColor = [UIColor clearColor];
	[self addSubview:lablename1];
	
	
	UILabel *lablename2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+10, XYViewTop(lablename1), 100, 20)];
	
	lablename2.font = FONTN(14.0f);
	lablename2.textColor = COLORNOW(117, 117, 117);
	lablename2.backgroundColor = [UIColor clearColor];
	[self addSubview:lablename2];
	
	
	UILabel *lablevalue1 = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablename1), XYViewBottom(lablename1)+5, SCREEN_WIDTH/2-50, 20)];
	lablevalue1.text = @"";
	lablevalue1.font = FONTMEDIUM(18.0f);
	lablevalue1.textColor = [UIColor blackColor];
	lablevalue1.backgroundColor = [UIColor clearColor];
	[self addSubview:lablevalue1];
	
    if(EnWaterPersonScanRebate == type)
    {
        UILabel *lablemoneyflag1 = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablevalue1)-10, XYViewTop(lablevalue1)+3, 10,10)];
        lablemoneyflag1.text = @"￥";
        lablemoneyflag1.font = FONTMEDIUM(11.0f);
        lablemoneyflag1.textColor = [UIColor blackColor];
        lablemoneyflag1.backgroundColor = [UIColor clearColor];
        [self addSubview:lablemoneyflag1];
    }
    
	UILabel *lablevalue2 = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablename2), XYViewTop(lablevalue1), SCREEN_WIDTH/2-50, 20)];
	lablevalue2.text = @"";
	lablevalue2.font = FONTMEDIUM(18.0f);
	lablevalue2.textColor = [UIColor blackColor];
	lablevalue2.backgroundColor = [UIColor clearColor];
	[self addSubview:lablevalue2];
	
    if(EnWaterPersonScanRebate == type)
    {
        UILabel *lablemoneyflag2 = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablevalue2)-10, XYViewTop(lablevalue2)+3, 10,10)];
        lablemoneyflag2.text = @"￥";
        lablemoneyflag2.font = FONTMEDIUM(11.0f);
        lablemoneyflag2.textColor = [UIColor blackColor];
        lablemoneyflag2.backgroundColor = [UIColor clearColor];
        [self addSubview:lablemoneyflag2];
    }
    
	UIButton *buttonmore = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonmore.frame = CGRectMake(SCREEN_WIDTH-50, 10, 40, 40);
	buttonmore.backgroundColor = [UIColor clearColor];
	[buttonmore setImage:LOADIMAGE(@"morepoint", @"png") forState:UIControlStateNormal];
	[buttonmore addTarget:self action:@selector(gotomore:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:buttonmore];
	
	switch (type) {
		case EnWaterPersonScanRebate:
			lablename.text = @"扫码返利";
			lablename1.text = @"一年提现金额";
			lablename2.text = @"三月提现金额";
			imageheader.image = LOADIMAGE(@"waterscanrebate", @"png");
			buttonmore.tag = EnWaterHpFunctionRebateBt;
            lablevalue1.text = [NSString stringWithFormat:@"%@",[dicdata objectForKey:@"takemoneyforoneyear"]];
            lablevalue2.text = [NSString stringWithFormat:@"%@",[dicdata objectForKey:@"takemoneyforthreemonth"]];
			break;
		case EnWaterPersonLogin:
			lablename.text = @"登录统计";
			lablename1.text = @"最近登录";
			
			imageheader.image = LOADIMAGE(@"water统计", @"png");
			buttonmore.tag = EnWaterHpFunctionLoginBt;
            lablevalue1.font = FONTN(14.0f);
            lablevalue1.frame = CGRectMake(XYViewL(lablevalue1), XYViewTop(lablevalue1), 250, XYViewHeight(lablevalue1));
            lablevalue1.textColor = COLORNOW(117, 117, 117);
            lablevalue1.text = [dicdata objectForKey:@"lastloginaddr"];
			break;
		case EnWaterPersonSocialinfo:
			lablename.text = @"社交";
			lablename1.text = @"粉丝";
			lablename2.text = @"关注";
			imageheader.image = LOADIMAGE(@"社交icon", @"png");
			buttonmore.tag = EnWaterHpFunctionSocialBt;
            lablevalue1.text = [NSString stringWithFormat:@"%@",[dicdata objectForKey:@"fansnumber"]];
            lablevalue2.text = [NSString stringWithFormat:@"%@",[dicdata objectForKey:@"focusnumber"]];
			break;
		case EnWaterPersonMetting:
			lablename.text = @"水电工会议";
			lablename1.text = @"一年订单";
			lablename2.text = @"三月订单";
			imageheader.image = LOADIMAGE(@"watermetting", @"png");
			buttonmore.tag = EnWaterHpFunctionMettingBt;
            lablevalue1.text = [NSString stringWithFormat:@"%@",[dicdata objectForKey:@"attendtimesforoneyear"]];
            lablevalue2.text = [NSString stringWithFormat:@"%@",[dicdata objectForKey:@"attendtimesforthreemonth"]];
			break;
		case EnWaterPersonService:
			lablename.text = @"预约服务";
			lablename1.text = @"登录次数";
			lablename2.text = @"在线时长";
			imageheader.image = LOADIMAGE(@"waterservice", @"png");
			buttonmore.tag = EnWaterHpFunctionServiceBt;
            lablevalue1.text = [NSString stringWithFormat:@"%@",[dicdata objectForKey:@"timesforoneyear"]];
            lablevalue2.text = [NSString stringWithFormat:@"%@",[dicdata objectForKey:@"timesforthreemonth"]];
			break;
        case EnWaterPersonOrder:
            lablename.text = @"订单";
            lablename1.text = @"一年接单金额";
            lablename2.text = @"三月接单金额";
            imageheader.image = LOADIMAGE(@"waterorder", @"png");
            buttonmore.tag = EnWaterHpFunctionServiceBt;
            lablevalue1.text = [NSString stringWithFormat:@"%@",[dicdata objectForKey:@"ordermoneyforoneyear"]];
            lablevalue2.text = [NSString stringWithFormat:@"%@",[dicdata objectForKey:@"ordermoneythreemonth"]];
            break;
			
	}
}


-(void)gotomore:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag];
	if([self.delegate1 respondsToSelector:@selector(DGClickWaterFunctionHp:)])
	{
		[self.delegate1 DGClickWaterFunctionHp:tagnow];
	}
}

@end
