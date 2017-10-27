//
//  TbeaHpCellView.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/13.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

/**
 0000-特变电工-首页对应页面
 **/

#import "TbeaHpCellView.h"

@implementation TbeaHpCellView

-(id)initWithFrame:(CGRect)frame ArrayFrom:(NSArray *)arrayfrom
{
	self = [super initWithFrame:frame];
	if(self)
	{
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		
		[self initviewwatercell:arrayfrom];
		
	}
	return self;
}

-(id)initWithFrameProduct:(CGRect)frame DicFrom:(NSDictionary *)dicfrom
{
	self = [super initWithFrame:frame];
	if(self)
	{
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		dicsrc = dicfrom;
		[self initviewproductcell:dicfrom];
		
	}
	return self;
}

//通知
-(void)initviewwatercell:(NSArray  *)arrayfrom
{
    NSDictionary *dictemp = [arrayfrom objectAtIndex:0];
	self.backgroundColor = COLORNOW(235, 235, 235);
	UIImageView *imageview =[[UIImageView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 40)];
	imageview.backgroundColor = [UIColor whiteColor];
	[self addSubview:imageview];
	
	UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 18, 20)];
	imageicon.image = LOADIMAGE(@"tbeabells", @"png");
	[self addSubview:imageicon];
	
	UILabel *labtitle = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageicon)+5,XYViewTop(imageicon), SCREEN_WIDTH-80, 20)];
	labtitle.text = [dictemp objectForKey:@"title"];
	labtitle.font = FONTLIGHT(15.0f);
	labtitle.textColor = COLORNOW(72, 72, 72);
	[self addSubview:labtitle];
	
	UIImageView *imageright = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-27, 24, 7, 12)];
	imageright.image = LOADIMAGE(@"tbeaarrowright", @"png");
	[self addSubview:imageright];
}

//产品
-(void)initviewproductcell:(NSDictionary *)dicfrom
{
	self.backgroundColor = [UIColor clearColor];

	UIImageView *imageview =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,XYViewWidth(self),XYViewWidth(self))];
	imageview.backgroundColor = [UIColor clearColor];
	imageview.contentMode = UIViewContentModeScaleAspectFill;
	imageview.clipsToBounds = YES;
	imageview.userInteractionEnabled = YES;
	UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickproductpic:)];
    NSString *strpic = [dicfrom objectForKey:@"thumbpicture"];//[NSString stringWithFormat:@"%@%@",InterfaceResource,[[dicfrom objectForKey:@"thumbpicture"] length]>0?[dicfrom objectForKey:@"thumbpicture"]:@"123"];
	[imageview addGestureRecognizer:singleTap];
    [imageview setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"tbeatestpic", @"png")];
    [self addSubview:imageview];
	
	NSString *str = [dicfrom objectForKey:@"name"];
	CGSize size = [AddInterface getlablesize:str Fwidth:XYViewWidth(imageview) Fheight:40 Sfont:FONTN(15.0f)];
	UILabel *labtitle = [[UILabel alloc] initWithFrame:CGRectMake(0,XYViewBottom(imageview)+5, size.width, size.height)];
	labtitle.text = str;
	labtitle.font = FONTN(15.0f);
	labtitle.numberOfLines = 0;
	labtitle.textColor = [UIColor blackColor];
	[self addSubview:labtitle];
	
	UILabel *labname = [[UILabel alloc] initWithFrame:CGRectMake(0,XYViewBottom(labtitle), XYViewWidth(imageview),20)];
	labname.text = [dicfrom objectForKey:@"specification"];
	labname.font = FONTN(13.0f);
	labname.textColor = COLORNOW(117, 117, 117);
	[self addSubview:labname];
}

-(void)clickproductpic:(UIGestureRecognizer *)sender
{
	if([self.delegate1 respondsToSelector:@selector(DGClickTbeaHpProduct:)])
	{
		[self.delegate1 DGClickTbeaHpProduct:dicsrc];
	}
}


@end
