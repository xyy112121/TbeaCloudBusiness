//
//  SearchPageView.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/23.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "SearchPageTopView.h"

@implementation SearchPageTopView

-(id)initWithgoods:(CGRect)frame  //进入搜索页面
{
	self = [super initWithFrame:frame];
	if(self)
	{
		[self initviewgoods];
	}
	return self;
}

-(void)initviewgoods
{
	self.backgroundColor = [UIColor whiteColor];
	self.layer.cornerRadius = 2.0f;
	self.clipsToBounds = YES;
	
	
//	UIButton *buttontype = [UIButton buttonWithType:UIButtonTypeCustom];
//	buttontype.titleLabel.font = FONTN(12.0f);
//	[buttontype setTitleColor:ColorBlackdeep forState:UIControlStateNormal];
//	[buttontype setImage:LOADIMAGE(@"", @"png") forState:<#(UIControlState)#>:@"商品" forState:UIControlStateNormal];
//	[buttontype addTarget:self action:@selector(returnback:) forControlEvents:UIControlEventTouchUpInside];
//	buttontype.frame = CGRectMake(3, 0, 40, 30);
//	[buttontype setBackgroundColor:[UIColor clearColor]];
//	[self addSubview:buttontype];
	
	UITextField *textfieldsearch = [[UITextField alloc] initWithFrame:CGRectMake(40, 1, self.frame.size.width-30,28)];
	textfieldsearch.backgroundColor = [UIColor clearColor];
	textfieldsearch.placeholder = @"输入搜索的名称";
	textfieldsearch.delegate = self;
	textfieldsearch.tag = EnSearchTextfieldCityTag3;
	textfieldsearch.textColor = ColorBlackdeep;
	textfieldsearch.returnKeyType = UIReturnKeySearch;
	[textfieldsearch setValue:COLORNOW(220, 220, 220) forKeyPath:@"_placeholderLabel.textColor"];
	textfieldsearch.font = FONTN(14.0f);
	[self addSubview:textfieldsearch];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	NSString *strUrl = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
	if([textField.text length]<2)
	{
		[MBProgressHUD showError:@"搜索内容至少需要2个字符" toView:app.window];
	}
	else if([strUrl length]<2)
	{
		[MBProgressHUD showError:@"搜索内容至少需要2个字符" toView:app.window];
	}
	else
	{
		if(textField.tag == EnSearchTextfieldCityTag3)
		{
			if([self.delgate1 respondsToSelector:@selector(DGClickSearchResultTextField:)])
			{
				[self.delgate1 DGClickSearchResultTextField:textField.text];
			}
			return NO;
		}
	}
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

    return YES;
}

-(void)selecttype:(id)sender
{
	
}

@end
