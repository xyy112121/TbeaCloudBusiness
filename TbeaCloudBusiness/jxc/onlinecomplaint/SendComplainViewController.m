//
//  SendComplainViewController.m
//  TeBian
//
//  Created by xyy520 on 15/12/16.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import "SendComplainViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "RequestInterface.h"

#import "JQIndicatorView.h"
#import "UIImageView+AFNetworking.h"
#import "AddInterface.h"
#import "YTextField.h"
@interface SendComplainViewController ()

@end

@implementation SendComplainViewController

@synthesize delegate1;

-(void)returnback:(id)sender
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	JQIndicatorView *indicator = [app.window viewWithTag:IndicatorTag];
	[indicator stopAnimating];
	[self.navigationController popViewControllerAnimated:YES];
}


-(void)sendcomplain:(NSString *)content MobileNumber:(NSString *)mobile
{
	NSString *postUrl = URLHeader;
	
	NSDictionary *parameters = @{@"Content":content,@"MobileNumber": mobile};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA14010000" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 if([[responseObject objectForKey:@"RspCode"] isEqualToString:@"RC00000"])
		 {
			 [self returnback:nil];
		 }
         [MBProgressHUD showError:[responseObject objectForKey:@"RspDesc"] toView:self.view];

	 }];
	
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"发起投诉";
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	[button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
	button.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
	[button addTarget:self action: @selector(returnback:) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	
	UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
	UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
	[buttonright setImage:LOADIMAGE(@"Confirm", @"png") forState:UIControlStateNormal];
	buttonright.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
	[buttonright addTarget:self action: @selector(gotocommit:) forControlEvents: UIControlEventTouchUpInside];
	[contentViewright addSubview:buttonright];
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
	self.navigationItem.rightBarButtonItem = barButtonItemright;
	
	[self initview:nil];
	// Do any additional setup after loading the view.
}

-(void)gotocommit:(id)sender
{
	UITextField *textfield = (UITextField *)[scrollview viewWithTag:621];
	UITextView *textview = (UITextView *)[scrollview viewWithTag:622];
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	if(([textfield.text length]==0)||([textview.text length]==0))
	{
        [MBProgressHUD showError:@"请填写完整投诉信息" toView:app.window];

	}
	else if(![AddInterface isValidateMobile:textfield.text])
	{
        [MBProgressHUD showError:@"投诉电话格式不正确" toView:app.window];

	}
	else
	{
		[self sendcomplain:textview.text MobileNumber:textfield.text];
	}
}

-(void)initview:(id)sender
{
	scrollview =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
	scrollview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:scrollview];
	
	UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(5, 10, SCREEN_WIDTH-10, 35)];
	textfield.layer.cornerRadius = 3;
	textfield.backgroundColor = [UIColor whiteColor];
	textfield.tag = 621;
	textfield.delegate = self;
	textfield.placeholder = @"填写投诉电话号码";
	textfield.font = FONTN(13.0f);
	textfield.returnKeyType = UIReturnKeySearch;
	textfield.clearButtonMode = UITextFieldViewModeAlways;
	UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
	textfield.leftView = leftview;
	leftview.userInteractionEnabled = NO;
	textfield.leftViewMode = UITextFieldViewModeAlways;
	[scrollview addSubview:textfield];
	
	UITextView *textview = [[UITextView alloc] initWithFrame:CGRectMake(textfield.frame.origin.x, textfield.frame.origin.y+textfield.frame.size.height+10,textfield.frame.size.width,160)];
	textview.font = FONTMEDIUM(14.0f);
	textview.textColor = COLORNOW(102, 102, 102);
	textview.delegate = self;
	textview.tag = 622;
	textview.layer.cornerRadius = 3.0f;
	textview.clipsToBounds = YES;
	[scrollview addSubview:textview];

}

-(void)gotodone:(id)sender
{
	
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
