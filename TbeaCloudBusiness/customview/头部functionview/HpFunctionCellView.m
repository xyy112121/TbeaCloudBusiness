//
//  HpFunctionCellView.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/27.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "HpFunctionCellView.h"

@implementation HpFunctionCellView

-(id)initWithFrame:(CGRect)frame celltype:(EnHpFunctionCellType)type Dic:(NSDictionary *)dic IndexPath:(NSIndexPath *)indexpath
{
	self = [super initWithFrame:frame];
	if(self)
	{
        FCdicdata = dic;
		if([[dic objectForKey:@"style"] isEqualToString:@"style01"])  //EnHpFunctionCellType1
			[self initviewtype1:dic IndexPath:indexpath];
        else if([[dic objectForKey:@"style"] isEqualToString:@"style04"])  //EnHpFunctionCellType4
            [self initviewtype4:dic IndexPath:indexpath];
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		self.backgroundColor = COLORNOW(235, 235, 235);
	}
	return self;
}

-(void)initviewtype1:(NSDictionary *)dic IndexPath:(NSIndexPath *)indexpath
{
	UIImageView *imageviewbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
	imageviewbg.backgroundColor = [UIColor whiteColor];
	[self addSubview:imageviewbg];
	
    NSString *stricon = [dic objectForKey:@"icon"];//[InterfaceResource stringByAppendingString:[dic objectForKey:@"icon"]];
	UIImageView *imageviewicon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 20, 20)];
	[imageviewicon setImageWithURL:[NSURL URLWithString:stricon]];
	[self addSubview:imageviewicon];
	
	UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageviewicon)+10, XYViewTop(imageviewicon), 100, 20)];
	lable.text = [dic objectForKey:@"name"];
	lable.font = FONTN(15.0f);
	lable.textColor = [UIColor blackColor];
	lable.backgroundColor = [UIColor clearColor];
	[self addSubview:lable];
	
	NSArray *arraysub = [dic objectForKey:@"subitemlist"];
	UILabel *lableispayvalue;
	UILabel *lableispayname;
	if([arraysub count]>0)
	{
		NSDictionary *dictemp = [arraysub objectAtIndex:0];
		lableispayname = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lable), XYViewBottom(lable)+10, SCREEN_WIDTH/2-20, 20)];
		lableispayname.text = [dictemp objectForKey:@"name"];
		lableispayname.font = FONTN(14.0f);
		lableispayname.textColor = COLORNOW(117, 117, 117);
		lableispayname.backgroundColor = [UIColor clearColor];
		[self addSubview:lableispayname];
		
		lableispayvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lable), XYViewBottom(lableispayname)+5, SCREEN_WIDTH/2-30, 25)];
		lableispayvalue.text = [dictemp objectForKey:@"value"];
		lableispayvalue.font = FONTMEDIUM(17.0f);
		lableispayvalue.textColor = [UIColor blackColor];
		lableispayvalue.backgroundColor = [UIColor clearColor];
		[self addSubview:lableispayvalue];
        
        if([[dictemp objectForKey:@"ismoney"] isEqualToString:@"1"])
        {
            UILabel *lablemoneyflag1 = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lableispayvalue)-10, XYViewTop(lableispayvalue)+5, 10,10)];
            lablemoneyflag1.text = @"￥";
            lablemoneyflag1.font = FONTMEDIUM(11.0f);
            lablemoneyflag1.textColor = [UIColor blackColor];
            lablemoneyflag1.backgroundColor = [UIColor clearColor];
            [self addSubview:lablemoneyflag1];
        }
	}
	
	if([arraysub count]>1)
	{
		NSDictionary *dictemp1 = [arraysub objectAtIndex:1];

		UILabel *lablenopayname = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+20, XYViewTop(lableispayname), SCREEN_WIDTH/2-20, 20)];
		lablenopayname.text = [dictemp1 objectForKey:@"name"];
		lablenopayname.font = FONTN(14.0f);
		lablenopayname.textColor = COLORNOW(117, 117, 117);
		lablenopayname.backgroundColor = [UIColor clearColor];
		[self addSubview:lablenopayname];
		
		UILabel *lablenopayvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablenopayname), XYViewTop(lableispayvalue), SCREEN_WIDTH/2-30, 25)];
		lablenopayvalue.text = [dictemp1 objectForKey:@"value"];
		lablenopayvalue.font = FONTMEDIUM(17.0f);
		lablenopayvalue.textColor = [UIColor blackColor];
		lablenopayvalue.backgroundColor = [UIColor clearColor];
		[self addSubview:lablenopayvalue];
        
        if([[dictemp1 objectForKey:@"ismoney"] isEqualToString:@"1"])
        {
            UILabel *lablemoneyflag1 = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablenopayvalue)-10, XYViewTop(lablenopayvalue)+5, 10,10)];
            lablemoneyflag1.text = @"￥";
            lablemoneyflag1.font = FONTMEDIUM(11.0f);
            lablemoneyflag1.textColor = [UIColor blackColor];
            lablemoneyflag1.backgroundColor = [UIColor clearColor];
            [self addSubview:lablemoneyflag1];
        }
	}
	//更多
	UIButton *buttonmore = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonmore.frame = CGRectMake(SCREEN_WIDTH-50, 0, 40, 40);
	buttonmore.backgroundColor = [UIColor clearColor];
    buttonmore.tag = EnHpFunctionCellMoreBtTag+indexpath.row;
	[buttonmore setImage:LOADIMAGE(@"morepoint", @"png") forState:UIControlStateNormal];
	[buttonmore addTarget:self action:@selector(gototixiandata:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:buttonmore];
}



-(void)initviewtype4:(NSDictionary *)dic IndexPath:(NSIndexPath *)indexpath
{
    UIImageView *imageviewbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, XYViewHeight(self)-10)];
    imageviewbg.backgroundColor = [UIColor whiteColor];
    [self addSubview:imageviewbg];
    
    NSString *stricon = [dic objectForKey:@"icon"];//[InterfaceResource stringByAppendingString:[dic objectForKey:@"icon"]];
    UIImageView *imageviewicon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 20, 20)];
    [imageviewicon setImageWithURL:[NSURL URLWithString:stricon]];
    [self addSubview:imageviewicon];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageviewicon)+10, XYViewTop(imageviewicon), 100, 20)];
    lable.text = [dic objectForKey:@"name"];
    lable.font = FONTN(15.0f);
    lable.textColor = [UIColor blackColor];
    lable.backgroundColor = [UIColor clearColor];
    [self addSubview:lable];
    
    //更多
    UIButton *buttonmore = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonmore.frame = CGRectMake(SCREEN_WIDTH-50, 0, 40, 40);
    buttonmore.backgroundColor = [UIColor clearColor];
    buttonmore.tag = EnHpFunctionCellMoreBtTag+indexpath.row;
    [buttonmore setImage:LOADIMAGE(@"morepoint", @"png") forState:UIControlStateNormal];
    [buttonmore addTarget:self action:@selector(gototixiandata:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonmore];
    
    NSArray *arraysub = [dic objectForKey:@"subitemlist"];

    if([arraysub count]>0)
    {
        NSDictionary *dictemp = [arraysub objectAtIndex:0];
        [self customfunctionlayout:dictemp Frame:CGRectMake(XYViewL(lable), XYViewBottom(lable)+10, SCREEN_WIDTH/2-20, 20)];
    }
    
    if([arraysub count]>1)
    {
        NSDictionary *dictemp1 = [arraysub objectAtIndex:1];
        [self customfunctionlayout:dictemp1 Frame:CGRectMake(SCREEN_WIDTH/2+20, XYViewBottom(lable)+10, SCREEN_WIDTH/2-20, 20)];
    }
    
    UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 1)];
    imageviewline.backgroundColor = COLORNOW(235, 235, 235);
    [self addSubview:imageviewline];
    
    if([arraysub count]>2)
    {
        NSDictionary *dictemp = [arraysub objectAtIndex:2];
        [self customfunctionlayout:dictemp Frame:CGRectMake(XYViewL(lable), XYViewBottom(imageviewline)+10, SCREEN_WIDTH/2-20, 20)];
    }
    
    if([arraysub count]>3)
    {
        NSDictionary *dictemp1 = [arraysub objectAtIndex:3];
        [self customfunctionlayout:dictemp1 Frame:CGRectMake(SCREEN_WIDTH/2+20, XYViewBottom(imageviewline)+10, SCREEN_WIDTH/2-20, 20)];
    }

}

-(void)customfunctionlayout:(NSDictionary *)dic Frame:(CGRect)frame
{
    UILabel *lablenopayname = [[UILabel alloc] initWithFrame:frame];
    lablenopayname.text = [dic objectForKey:@"name"];
    lablenopayname.font = FONTN(14.0f);
    lablenopayname.textColor = COLORNOW(117, 117, 117);
    lablenopayname.backgroundColor = [UIColor clearColor];
    [self addSubview:lablenopayname];
    
    UILabel *lablenopayvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablenopayname), XYViewBottom(lablenopayname)+5, SCREEN_WIDTH/2-30, 25)];
    lablenopayvalue.text = [dic objectForKey:@"value"];
    lablenopayvalue.font = FONTMEDIUM(17.0f);
    lablenopayvalue.textColor = [UIColor blackColor];
    lablenopayvalue.backgroundColor = [UIColor clearColor];
    [self addSubview:lablenopayvalue];
    
    if([[dic objectForKey:@"ismoney"] isEqualToString:@"1"])
    {
        UILabel *lablemoneyflag1 = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablenopayvalue)-10, XYViewTop(lablenopayvalue)+5, 10,10)];
        lablemoneyflag1.text = @"￥";
        lablemoneyflag1.font = FONTMEDIUM(11.0f);
        lablemoneyflag1.textColor = [UIColor blackColor];
        lablemoneyflag1.backgroundColor = [UIColor clearColor];
        [self addSubview:lablemoneyflag1];
    }
}

-(void)gototixiandata:(id)sender
{

    if([self.delegate1 respondsToSelector:@selector(DGClickFunctionGotoView:)])
    {
        
        [self.delegate1 DGClickFunctionGotoView:FCdicdata];
    }
    
}

@end
