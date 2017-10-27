//
//  HpNavigateView.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/2/20.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "HpNavigateView.h"

@implementation HpNavigateView

-(id)initWithFrame:(CGRect)frame FromFlag:(NSString *)from
{
	self = [super initWithFrame:frame];
	if (self)
	{
		fromflag = from;
        [self initview];
	}
	return self;
}

-(void)initview
{
	self.backgroundColor = COLORNOW(0, 170, 238);
	
	UIButton *buttonheader = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonheader.frame= CGRectMake(10, 2, 40, 40);
	[buttonheader setImage:LOADIMAGE(@"hpmessage", @"png") forState:UIControlStateNormal];
    [buttonheader addTarget:self action:@selector(gotoMessage:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:buttonheader];
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(buttonheader.frame.origin.x+buttonheader.frame.size.width+10, (self.frame.size.height-28)/2, SCREEN_WIDTH-120, 28)];
	imageview.layer.cornerRadius = 4.0f;
	imageview.clipsToBounds = YES;
    imageview.backgroundColor = [UIColor whiteColor];
	[self addSubview:imageview];
	
	UIImageView *imageviewsearch = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+5,imageview.frame.origin.y+6, 16, 16)];
	imageviewsearch.image = LOADIMAGE(@"hp_searchicon", @"png");
	[self addSubview:imageviewsearch];
	
	
	UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(imageviewsearch.frame.origin.x+imageviewsearch.frame.size.width+3, imageview.frame.origin.y+2, imageview.frame.size.width-imageviewsearch.frame.size.width-10, 24)];
	textfield.backgroundColor = [UIColor clearColor];
	textfield.delegate = self;
	textfield.font = FONTN(14.0f);
	textfield.placeholder = @"输入关键词模糊查询";
	[self addSubview:textfield];
	
	UIButton *buttonQrcode = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonQrcode.layer.borderColor = [UIColor clearColor].CGColor;
	buttonQrcode.frame= CGRectMake(SCREEN_WIDTH-50, 2, 40, 40);
	[buttonQrcode setImage:LOADIMAGE(@"hpscanqr", @"png") forState:UIControlStateNormal];
	[buttonQrcode addTarget:self action:@selector(gotoqrcode:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:buttonQrcode];
	
	
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if([self.delegate1 respondsToSelector:@selector(DGClickGoToSearch:)])
	{
		[self.delegate1 DGClickGoToSearch:nil];
	}
	return NO;
}

-(void)gotoqrcode:(id)sender
{
	if([self.delegate1 respondsToSelector:@selector(DGCLickScanCode:)])
	{
		[self.delegate1 DGCLickScanCode:nil];
	}
}


-(void)gotoMessage:(id)sender
{
    if([self.delegate1 respondsToSelector:@selector(DGclickMessage:)])
    {
        [self.delegate1 DGclickMessage:sender];
    }
}


@end
