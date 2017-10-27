//
//  SearchTextFieldView.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/21.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "SearchTextFieldView.h"

@implementation SearchTextFieldView

-(id)initWithFrame:(CGRect)frame Pastr:(NSString *)pastr
{
	self = [super initWithFrame:frame];
	if(self)
	{
		[self initview:pastr];
		self.layer.cornerRadius = 2.0f;
		self.clipsToBounds = YES;
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		self.backgroundColor = [UIColor whiteColor];
	}
	return self;
}

-(void)initview:(NSString *)pastr
{
	UIImageView *imagesearch = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.height-10, self.frame.size.height-10)];
	imagesearch.image = LOADIMAGE(@"hp_searchicon", @"png");
	[self addSubview:imagesearch];
	
	UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(XYViewR(imagesearch)+5,3, 150, XYViewHeight(self)-6)];
	textfield.placeholder = pastr;
	textfield.delegate = self;
	textfield.font = FONTN(14.0f);
	[self addSubview:textfield];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if([self.delegate1 respondsToSelector:@selector(DGClickGoToSearch:)])
    {
        [self.delegate1 DGClickGoToSearch:nil];
    }
    return NO;
}

@end
