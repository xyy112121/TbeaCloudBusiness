//
//  ButtonItemLayoutView.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ButtonItemLayoutView.h"

@implementation ButtonItemLayoutView
@synthesize button;


-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if(self)
	{
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		self.backgroundColor = [UIColor clearColor];
		self.labelname = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width-15, 20)];
		self.labelname.backgroundColor = [UIColor clearColor];
		[self addSubview:self.labelname];
		
		self.imageviewicon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 6, 5)];
		[self addSubview:self.imageviewicon];
		
		self.button = [UIButton buttonWithType:UIButtonTypeCustom];
		self.button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
		[self addSubview:self.button];
//		[self.button addTarget:self action:@selector(clicktest:) forControlEvents:UIControlEventTouchUpInside];
	}
	return self;
}

-(void)updatebuttonitem:(EnButtonTextAlignment)textalignment TextStr:(NSString *)textstr  Font:(UIFont *)font Color:(UIColor *)color Image:(UIImage *)image
{
	CGSize size = [AddInterface getlablesize:textstr Fwidth:self.frame.size.width-10 Fheight:20 Sfont:font];
	if(textalignment==EnButtonTextLeft)
	{
		self.labelname.frame = CGRectMake(10, 10, size.width, size.height);
	}
	else if(textalignment==EnButtonTextCenter)
	{
		self.labelname.frame = CGRectMake((self.frame.size.width-size.width-10)/2, 10, size.width, size.height);
	}
	else
	{
		self.labelname.frame = CGRectMake(self.frame.size.width-size.width-10, 10, size.width, size.height);
	}
	self.labelname.text = textstr;
	self.labelname.font = font;
	self.labelname.textColor = color;
	
	self.imageviewicon.frame = CGRectMake(XYViewR(self.labelname)+3, (XYViewHeight(self)-image.size.height)/2, image.size.width, image.size.height);
	self.imageviewicon.image = image;
}

-(void)updatelablecolor:(UIColor *)color
{
	self.labelname.textColor = color;
}

-(void)updatelabstr:(NSString *)textstr
{
	CGSize size = [AddInterface getlablesize:textstr Fwidth:self.frame.size.width-10 Fheight:20 Sfont:self.labelname.font];
	self.labelname.text = textstr;
	self.labelname.frame = CGRectMake(XYViewL(self.labelname), XYViewTop(self.labelname), size.width, 20);
	self.imageviewicon.frame = CGRectMake(XYViewR(self.labelname)+3, (XYViewHeight(self)-self.imageviewicon.frame.size.height)/2, self.imageviewicon.frame.size.width, XYViewHeight(self.imageviewicon));
}

-(void)updateimage:(UIImage *)image
{
	self.imageviewicon.image = image;
}

-(void)clicktest:(id)sender
{
	NSLog(@"123123123123123123");
}

@end
