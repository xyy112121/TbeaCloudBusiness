//
//  ReturnMoneyDetailViewController.m
//  TeBian
//
//  Created by xyy520 on 15/12/21.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import "ReturnMoneyDetailViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "RequestInterface.h"

#import "JQIndicatorView.h"
#import "UIImageView+AFNetworking.h"
#import "AddInterface.h"
@interface ReturnMoneyDetailViewController ()

@end

@implementation ReturnMoneyDetailViewController
@synthesize strorderid;

-(void)returnback:(id)sender
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	JQIndicatorView *indicator = [app.window viewWithTag:IndicatorTag];
	[indicator stopAnimating];
	[self.navigationController popViewControllerAnimated:YES];
}

-(void) requestJXReturnmoneyDetail:(NSString *)page Pagesize:(NSString *)pagesize Orderid:(NSString *)orderid
{
	NSString *postUrl = URLHeader;
	
	NSDictionary *parameters = @{@"OrderId":orderid,@"Page": page,@"PageSize":pagesize};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA08010100" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 [self initview:[responseObject objectForKey:@"OrderInfo"]];
		 NSString *htmlstr = [[responseObject objectForKey:@"ReceivedMoneyList"] objectForKey:@"html"];
		 [self.webview loadHTMLString:htmlstr baseURL:nil];
	 }];
	
	
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	self.view.backgroundColor = [UIColor whiteColor];
	
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"回款明细";
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	[button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
	
	button.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
	[button addTarget:self action: @selector(returnback:) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	
	[self requestJXReturnmoneyDetail:@"1" Pagesize:@"10" Orderid:self.strorderid];
    // Do any additional setup after loading the view.
}

-(void)initview:(NSDictionary *)sender
{
	//客户名称
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10,10, 60, 20)];
	labelname.font = FONTN(13.0f);
	labelname.text = @"客户名称";
	labelname.textColor = COLORNOW(151, 151, 151);
	[self.view addSubview:labelname];
	
	UILabel *labelnamevalue = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x+labelname.frame.size.width+10,labelname.frame.origin.y, 150, 20)];
	labelnamevalue.font = FONTB(12.0f);
	labelnamevalue.text = [sender objectForKey:@"CustomerName"];
	labelnamevalue.textColor = COLORNOW(51, 51, 51);
	[self.view addSubview:labelnamevalue];
	
	UIImageView *imageviewline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 0.5)];
	imageviewline1.backgroundColor = COLORNOW(211, 211, 211);
	[self.view addSubview:imageviewline1];
	
	//订单编号
	UILabel *labelcode = [[UILabel alloc] initWithFrame:CGRectMake(10,imageviewline1.frame.origin.y+10, 60, 20)];
	labelcode.font = FONTN(13.0f);
	labelcode.text = @"订单编号";
	labelcode.textColor = COLORNOW(151, 151, 151);
	[self.view addSubview:labelcode];
	
	UILabel *labelcodevalue = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x+labelname.frame.size.width+10,labelcode.frame.origin.y, 150, 20)];
	labelcodevalue.font = FONTN(12.0f);
	labelcodevalue.text = [sender objectForKey:@"OrderCode"];
	labelcodevalue.textColor = COLORNOW(51, 51, 51);
	[self.view addSubview:labelcodevalue];
	
	UIImageView *imageviewline2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageviewline1.frame.origin.y+40, SCREEN_WIDTH, 0.5)];
	imageviewline2.backgroundColor = COLORNOW(211, 211, 211);
	[self.view addSubview:imageviewline2];
	
	//订单编号
	UILabel *labelallmoney = [[UILabel alloc] initWithFrame:CGRectMake(10,imageviewline2.frame.origin.y+10, 65, 20)];
	labelallmoney.font = FONTN(12.0f);
	labelallmoney.text = @"订单总金额";
	labelallmoney.textColor = COLORNOW(151, 151, 151);
	[self.view addSubview:labelallmoney];
	
	UILabel *labelallmoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(labelallmoney.frame.origin.x+labelallmoney.frame.size.width,labelallmoney.frame.origin.y, SCREEN_WIDTH/2-10-60, 20)];
	labelallmoneyvalue.font = FONTN(12.0f);
	labelallmoneyvalue.text = [NSString stringWithFormat:@"￥%@",[sender objectForKey:@"OrderMoney"]];
	labelallmoneyvalue.textColor = COLORNOW(255, 102, 0);
	[self.view addSubview:labelallmoneyvalue];
	
	UILabel *labelyifamoney = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+10,labelallmoney.frame.origin.y, 65, 20)];
	labelyifamoney.font = FONTN(12.0f);
	labelyifamoney.text = @"已发货金额";
	labelyifamoney.textColor = COLORNOW(151, 151, 151);
	[self.view addSubview:labelyifamoney];
	
	UILabel *labelyifamoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(labelyifamoney.frame.origin.x+labelyifamoney.frame.size.width,labelyifamoney.frame.origin.y, SCREEN_WIDTH/2-10-60, 20)];
	labelyifamoneyvalue.font = FONTN(12.0f);
	labelyifamoneyvalue.text = [NSString stringWithFormat:@"￥%@",[sender objectForKey:@"DeliveryMoney"]];
	labelyifamoneyvalue.textColor = COLORNOW(51, 153, 0);
	[self.view addSubview:labelyifamoneyvalue];
	
	UILabel *labelhuikuanmoney = [[UILabel alloc] initWithFrame:CGRectMake(10,labelallmoney.frame.origin.y+labelallmoney.frame.size.height+5, 65, 20)];
	labelhuikuanmoney.font = FONTN(12.0f);
	labelhuikuanmoney.text = @"已回款金额";
	labelhuikuanmoney.textColor = COLORNOW(151, 151, 151);
	[self.view addSubview:labelhuikuanmoney];
	
	UILabel *labelhuikuanmoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(labelhuikuanmoney.frame.origin.x+labelhuikuanmoney.frame.size.width,labelhuikuanmoney.frame.origin.y, SCREEN_WIDTH/2-10-60, 20)];
	labelhuikuanmoneyvalue.font = FONTN(12.0f);
	labelhuikuanmoneyvalue.text = [NSString stringWithFormat:@"￥%@",[sender objectForKey:@"TotleReceivedMoney"]];
	labelhuikuanmoneyvalue.textColor = COLORNOW(102, 153, 204);
	[self.view addSubview:labelhuikuanmoneyvalue];
	
	UILabel *labelsoukuanmoney = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+10,labelhuikuanmoney.frame.origin.y, 65, 20)];
	labelsoukuanmoney.font = FONTN(12.0f);
	labelsoukuanmoney.text = @"已收款余额";
	labelsoukuanmoney.textColor = COLORNOW(151, 151, 151);
	[self.view addSubview:labelsoukuanmoney];
	
	UILabel *labelsoukuanmoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(labelsoukuanmoney.frame.origin.x+labelsoukuanmoney.frame.size.width,labelsoukuanmoney.frame.origin.y, SCREEN_WIDTH/2-10-60, 20)];
	labelsoukuanmoneyvalue.font = FONTN(12.0f);
	labelsoukuanmoneyvalue.text = [NSString stringWithFormat:@"￥%@",[sender objectForKey:@"TotleLeftMoney"]];
	labelsoukuanmoneyvalue.textColor = COLORNOW(151, 151, 151);
	[self.view addSubview:labelsoukuanmoneyvalue];
	
	UIImageView *imageviewline3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageviewline2.frame.origin.y+70, SCREEN_WIDTH, 0.5)];
	imageviewline3.backgroundColor = COLORNOW(211, 211, 211);
	[self.view addSubview:imageviewline3];
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
