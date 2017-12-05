//
//  WaterPersonHpHeaderView.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/31.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "WaterPersonHpHeaderView.h"

@implementation WaterPersonHpHeaderView

-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom
{
	self = [super initWithFrame:frame];
	if(self)
	{
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		self.backgroundColor = [UIColor whiteColor];
		[self initview:dicfrom];
		
	}
	return self;
}


-(void)initview:(NSDictionary  *)dicfrom
{
    NSDictionary *dicbaseinfo = [dicfrom objectForKey:@"electricianbaseinfo"];
	UIImageView *imageviewtop = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
	imageviewtop.image = LOADIMAGE(@"watertest", @"png");
	[self addSubview:imageviewtop];
	
	UIImageView *imagebg = [[UIImageView alloc] initWithFrame:CGRectMake(0,140,SCREEN_WIDTH,XYViewHeight(self)-140)];
	imagebg.backgroundColor = [UIColor whiteColor];
	[self addSubview:imagebg];
	
	NSString *strname = [dicbaseinfo objectForKey:@"personname"];
	CGSize size = [AddInterface getlablesize:strname Fwidth:200 Fheight:20 Sfont:FONTMEDIUM(17.0f)];
	UILabel *lablename = [[UILabel alloc] initWithFrame:CGRectMake(20, XYViewBottom(imageviewtop)+10, size.width, 20)];
	lablename.text = strname;
	lablename.font = FONTMEDIUM(17.0f);
	lablename.textColor = [UIColor blackColor];
	lablename.backgroundColor = [UIColor clearColor];
	[self addSubview:lablename];
	
	UIImageView *imageusericon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(lablename)+5,XYViewTop(lablename)+5,25,10)];
    NSString *stricon = [dicbaseinfo objectForKey:@"persontypeicon"];
    [imageusericon setImageWithURL:[NSURL URLWithString:stricon]];
	[self addSubview:imageusericon];
	
//    UIButton *buttonarrow = [UIButton buttonWithType:UIButtonTypeCustom];
//    buttonarrow.frame = CGRectMake(XYViewR(imageusericon)+10, XYViewTop(lablename)-5, 40, 30);
//    buttonarrow.backgroundColor = [UIColor clearColor];
//    [buttonarrow setImage:LOADIMAGE(@"tbeaarrowright", @"png") forState:UIControlStateNormal];
//    [buttonarrow addTarget:self action:@selector(photoTappedAd:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:buttonarrow];
    
    UIImageView *imageusericonaddr = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewL(lablename),XYViewBottom(lablename)+15,7,10)];
    imageusericonaddr.image = LOADIMAGE(@"waterlocationblue", @"png");
    [self addSubview:imageusericonaddr];
    
    UILabel *lableaddr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageusericonaddr)+5, XYViewTop(imageusericonaddr)-5, 180, 20)];
    lableaddr.text = [dicbaseinfo objectForKey:@"address"];
    lableaddr.font = FONTN(13.0f);
    lableaddr.textColor = COLORNOW(117, 117, 117);
    lableaddr.backgroundColor = [UIColor clearColor];
    [self addSubview:lableaddr];
	
//	UIImageView *imageusericonheader = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewL(lablename),XYViewBottom(lablename)+10,7,10)];
//	imageusericonheader.image = LOADIMAGE(@"waterwomen", @"png");
//	[self addSubview:imageusericonheader];
	
	UILabel *lableage = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(imageusericonaddr), XYViewBottom(lableaddr)+5, 130, 20)];
	lableage.text = [NSString stringWithFormat:@"工龄:%@",[dicbaseinfo objectForKey:@"workyears"]];
	lableage.font = FONTN(13.0f);
	lableage.textColor = COLORNOW(117, 117, 117);
	lableage.backgroundColor = [UIColor clearColor];
	[self addSubview:lableage];
	
	UIImageView *imageuserheader = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70,140-25,50,50)];
	imageuserheader.layer.cornerRadius =25;
	imageuserheader.clipsToBounds = YES;
    NSString *strpic = [dicbaseinfo objectForKey:@"thumbpicture"];//[InterfaceResource stringByAppendingString:[[dicbaseinfo objectForKey:@"thumbpicture"] length]>0?[dicbaseinfo objectForKey:@"thumbpicture"]:@"noimage.png"];
    [imageuserheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"scanrebatetest1", @"png")];
	imageuserheader.userInteractionEnabled = YES;
	UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedAd:)];
	[imageuserheader addGestureRecognizer:singleTap];
	[self addSubview:imageuserheader];
	
    
    UIImageView *imageuserxin = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-88, XYViewTop(lableaddr)+5, 68, 10)];
    [self addSubview:imageuserxin];
    switch ([[dicbaseinfo objectForKey:@"starlevel"] intValue])
    {
        case 0:
            imageuserxin.image = LOADIMAGE(@"0xin", @"png");
            break;
        case 1:
            imageuserxin.image = LOADIMAGE(@"1xin", @"png");
            break;
        case 2:
            imageuserxin.image = LOADIMAGE(@"2xin", @"png");
            break;
        case 3:
            imageuserxin.image = LOADIMAGE(@"3xin", @"png");
            break;
        case 4:
            imageuserxin.image = LOADIMAGE(@"4xin", @"png");
            break;
        case 5:
            imageuserxin.image = LOADIMAGE(@"5xin", @"png");
            break;

    }

	
	//关注数  粉丝数
	UILabel *lablefensi = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150, XYViewTop(lableage), 130, 20)];
	lablefensi.text = [NSString stringWithFormat:@"粉丝:%@",[dicbaseinfo objectForKey:@"fansnumber"]];
	lablefensi.font = FONTN(13.0f);
	lablefensi.textAlignment = NSTextAlignmentRight;
	lablefensi.textColor = COLORNOW(117, 117, 117);
	lablefensi.backgroundColor = [UIColor clearColor];
	[self addSubview:lablefensi];
	
//	UILabel *lableguanzhuvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(lablefensivalue)+10, XYViewTop(lablefensivalue), 60, 20)];
//	lableguanzhuvalue.text = [NSString stringWithFormat:@"%@",[dicbaseinfo objectForKey:@"attentnumber"]];
//	lableguanzhuvalue.font = FONTMEDIUM(16.0f);
//	lableguanzhuvalue.textAlignment = NSTextAlignmentCenter;
//	lableguanzhuvalue.textColor = [UIColor blackColor];
//	lableguanzhuvalue.backgroundColor = [UIColor clearColor];
//	[self addSubview:lableguanzhuvalue];
//	
//	UILabel *lableguanzhu = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lableguanzhuvalue), XYViewBottom(lableguanzhuvalue), XYViewWidth(lableguanzhuvalue), 20)];
//	lableguanzhu.text = @"关注";
//	lableguanzhu.font = FONTN(13.0f);
//	lableguanzhu.textAlignment = NSTextAlignmentCenter;
//	lableguanzhu.textColor = COLORNOW(117, 117, 117);
//	lableguanzhu.backgroundColor = [UIColor clearColor];
//	[self addSubview:lableguanzhu];
	
	
//	UIButton *buttonguanzhu = [UIButton buttonWithType:UIButtonTypeCustom];
//	buttonguanzhu.frame = CGRectMake(SCREEN_WIDTH-90, XYViewTop(lableguanzhuvalue)+3, 75, 26);
//	buttonguanzhu.backgroundColor = COLORNOW(0, 170, 236);
//	[buttonguanzhu setTitle:@"关注" forState:UIControlStateNormal];
//	buttonguanzhu.layer.cornerRadius = 2.0f;
//	buttonguanzhu.clipsToBounds = YES;
//	buttonguanzhu.titleLabel.font = FONTN(15.0f);
//	[buttonguanzhu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//	[buttonguanzhu addTarget:self action:@selector(gotomore:) forControlEvents:UIControlEventTouchUpInside];
//	[self addSubview:buttonguanzhu];
	
}

-(void)photoTappedAd:(UIGestureRecognizer*)sender
{
	if([self.delegate1 respondsToSelector:@selector(DGCLickWaterPersonHeader:)])
	{
		[self.delegate1 DGCLickWaterPersonHeader:sender];
	}
}

-(void)gotomore:(id)sender
{
	
}

@end
