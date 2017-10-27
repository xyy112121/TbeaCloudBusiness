//
//  ReturnSearchViewController.m
//  TeBian
//
//  Created by xyy520 on 15/12/16.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import "ReturnSearchViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "RequestInterface.h"

#import "JQIndicatorView.h"
#import "UIImageView+AFNetworking.h"
#import "AddInterface.h"
#import "YTextField.h"

@interface ReturnSearchViewController ()

@end

@implementation ReturnSearchViewController

@synthesize delegate1;

-(void)returnback:(id)sender
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	JQIndicatorView *indicator = [app.window viewWithTag:IndicatorTag];
	[indicator stopAnimating];
	[self.navigationController popViewControllerAnimated:YES];
}

//订单列表
-(void) requestJXSearch:(NSString *)statusid Page:(NSString *)page Pagesize:(NSString *)pagesize
{
	NSString *postUrl = URLHeader;
	
	NSDictionary *parameters = @{@"ReadStatusId":statusid,@"Page": page,@"PageSize":pagesize};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA05030000" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);

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
	self.title = @"查询";
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	[button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
	
	button.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
	[button addTarget:self action: @selector(returnback:) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	
	[self initview:nil];
	// Do any additional setup after loading the view.
}

-(void)initview:(id)sender
{
	UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(3, 11, 13, 13)];
	img.image = LOADIMAGE(@"zoomicon", @"png");
	YTextField *textfieldusername = [[YTextField alloc] initWithFrame:CGRectMake(30, 30, SCREEN_WIDTH-60, 35) Icon:img];
	textfieldusername.leftView = img;
	textfieldusername.placeholder = @"产品名称";
	textfieldusername.font = FONTLIGHT(14.0f);
	textfieldusername.tag = 101;
	textfieldusername.returnKeyType = UIReturnKeyDone;
	textfieldusername.delegate = self;
	textfieldusername.backgroundColor = [UIColor clearColor];
	textfieldusername.leftViewMode = UITextFieldViewModeAlways;
	textfieldusername.borderStyle = UITextBorderStyleLine;
	textfieldusername.textAlignment = NSTextAlignmentLeft;//  = UIControlContentVerticalAlignmentCenter;
	textfieldusername.layer.borderColor = COLORNOW(220, 220, 220).CGColor;
	textfieldusername.layer.borderWidth = 1.0f;
	[self.view addSubview:textfieldusername];
	
	UIButton *buttondone = [UIButton buttonWithType:UIButtonTypeCustom];
	buttondone.frame = CGRectMake(30,75, textfieldusername.frame.size.width, 35);
	buttondone.titleLabel.font = FONTN(15.0f);
	buttondone.backgroundColor = COLORNOW(0, 104, 183);
	buttondone.layer.cornerRadius = 3.0f;
	buttondone.clipsToBounds = YES;
	[buttondone setTitleColor:COLORNOW(240, 240, 240) forState:UIControlStateNormal];
	[buttondone addTarget:self action:@selector(gotodone:) forControlEvents:UIControlEventTouchUpInside];
	[buttondone setTitle:@"查询" forState:UIControlStateNormal];
	[self.view addSubview:buttondone];
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
