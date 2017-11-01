//
//  JXOrderProductDetailViewController.m
//  TeBian
//
//  Created by xyy520 on 16/2/26.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "JXOrderProductDetailViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "RequestInterface.h"

#import "JQIndicatorView.h"
#import "UIImageView+AFNetworking.h"
#import "AddInterface.h"
@interface JXOrderProductDetailViewController ()

@end

@implementation JXOrderProductDetailViewController
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
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA07020100" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 [self initview:[responseObject objectForKey:@"OrderInfo"]];
		 arraydata = [responseObject objectForKey:@"CommodityList"];
		 self.tableview.delegate = self;
		 self.tableview.dataSource= self;
		 [self.tableview reloadData];
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
	self.title = @"订货产品明细";
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	[button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
	
	button.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
	[button addTarget:self action: @selector(returnback:) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-40)];
    self.tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableview];
    [self setExtraCellLineHidden:self.tableview];
    
	[self requestJXReturnmoneyDetail:@"1" Pagesize:@"10" Orderid:self.strorderid];
	// Do any additional setup after loading the view.
}

-(void)initview:(NSDictionary *)sender
{
	//客户名称
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
	viewheader.backgroundColor = [UIColor clearColor];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10,10, 60, 20)];
	labelname.font = FONTN(13.0f);
	labelname.text = @"客户名称";
	labelname.textColor = COLORNOW(151, 151, 151);
	[viewheader addSubview:labelname];
	
	UILabel *labelnamevalue = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x+labelname.frame.size.width+10,labelname.frame.origin.y, 150, 20)];
	labelnamevalue.font = FONTB(12.0f);
	labelnamevalue.text = [sender objectForKey:@"CustomerName"];
	labelnamevalue.textColor = COLORNOW(51, 51, 51);
	[viewheader addSubview:labelnamevalue];
	
	UIImageView *imageviewline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 0.5)];
	imageviewline1.backgroundColor = COLORNOW(211, 211, 211);
	[viewheader addSubview:imageviewline1];
	
	//订单编号
	UILabel *labelcode = [[UILabel alloc] initWithFrame:CGRectMake(10,imageviewline1.frame.origin.y+10, 60, 20)];
	labelcode.font = FONTN(13.0f);
	labelcode.text = @"订单编号";
	labelcode.textColor = COLORNOW(151, 151, 151);
	[viewheader addSubview:labelcode];
	
	UILabel *labelcodevalue = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x+labelname.frame.size.width+10,labelcode.frame.origin.y, 150, 20)];
	labelcodevalue.font = FONTN(12.0f);
	labelcodevalue.text = [sender objectForKey:@"OrderCode"];
	labelcodevalue.textColor = COLORNOW(51, 51, 51);
	[viewheader addSubview:labelcodevalue];
	
	UIImageView *imageviewline2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageviewline1.frame.origin.y+40, SCREEN_WIDTH, 0.5)];
	imageviewline2.backgroundColor = COLORNOW(211, 211, 211);
	[viewheader addSubview:imageviewline2];
	
	//订单编号
	UILabel *labelallmoney = [[UILabel alloc] initWithFrame:CGRectMake(10,imageviewline2.frame.origin.y+10, 70, 20)];
	labelallmoney.font = FONTN(12.0f);
	labelallmoney.text = @"签订日期";
	labelallmoney.textColor = COLORNOW(151, 151, 151);
	[viewheader addSubview:labelallmoney];
	
	UILabel *labelallmoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(labelallmoney.frame.origin.x+labelallmoney.frame.size.width,labelallmoney.frame.origin.y, SCREEN_WIDTH/2-10-80, 20)];
	labelallmoneyvalue.font = FONTN(12.0f);
	labelallmoneyvalue.text = [NSString stringWithFormat:@"%@",[sender objectForKey:@"OrderDate"]];
	labelallmoneyvalue.textColor = COLORNOW(255, 102, 0);
	[viewheader addSubview:labelallmoneyvalue];
	
	UILabel *labelyifamoney = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+10,labelallmoney.frame.origin.y, 70, 20)];
	labelyifamoney.font = FONTN(12.0f);
	labelyifamoney.text = @"评审交货期";
	labelyifamoney.textColor = COLORNOW(151, 151, 151);
	[viewheader addSubview:labelyifamoney];
	
	UILabel *labelyifamoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(labelyifamoney.frame.origin.x+labelyifamoney.frame.size.width,labelyifamoney.frame.origin.y, SCREEN_WIDTH/2-10-80, 20)];
	labelyifamoneyvalue.font = FONTN(12.0f);
	labelyifamoneyvalue.text = [NSString stringWithFormat:@"%@",[sender objectForKey:@"AllDeliveryDate"]];
	labelyifamoneyvalue.textColor = COLORNOW(51, 153, 0);
	[viewheader addSubview:labelyifamoneyvalue];
	
	UILabel *labelhuikuanmoney = [[UILabel alloc] initWithFrame:CGRectMake(10,labelallmoney.frame.origin.y+labelallmoney.frame.size.height+5, 70, 20)];
	labelhuikuanmoney.font = FONTN(12.0f);
	labelhuikuanmoney.text = @"订单总金额";
	labelhuikuanmoney.textColor = COLORNOW(151, 151, 151);
	[viewheader addSubview:labelhuikuanmoney];
	
	UILabel *labelhuikuanmoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(labelhuikuanmoney.frame.origin.x+labelhuikuanmoney.frame.size.width,labelhuikuanmoney.frame.origin.y, SCREEN_WIDTH/2-10-70, 20)];
	labelhuikuanmoneyvalue.font = FONTN(12.0f);
	labelhuikuanmoneyvalue.text = [NSString stringWithFormat:@"￥%@",[sender objectForKey:@"OrderMoney"]];
	labelhuikuanmoneyvalue.textColor = COLORNOW(102, 153, 204);
	[viewheader addSubview:labelhuikuanmoneyvalue];
	
	UILabel *labelsoukuanmoney = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+10,labelhuikuanmoney.frame.origin.y, 70, 20)];
	labelsoukuanmoney.font = FONTN(12.0f);
	labelsoukuanmoney.text = @"已发货金额";
	labelsoukuanmoney.textColor = COLORNOW(151, 151, 151);
	[viewheader addSubview:labelsoukuanmoney];
	
	UILabel *labelsoukuanmoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(labelsoukuanmoney.frame.origin.x+labelsoukuanmoney.frame.size.width,labelsoukuanmoney.frame.origin.y, SCREEN_WIDTH/2-10-80, 20)];
	labelsoukuanmoneyvalue.font = FONTN(12.0f);
	labelsoukuanmoneyvalue.text = [NSString stringWithFormat:@"￥%@",[sender objectForKey:@"DeliveryMoney"]];
	labelsoukuanmoneyvalue.textColor = COLORNOW(151, 151, 151);
	[viewheader addSubview:labelsoukuanmoneyvalue];
	
	UIImageView *imageviewline3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageviewline2.frame.origin.y+70, SCREEN_WIDTH, 0.5)];
	imageviewline3.backgroundColor = COLORNOW(211, 211, 211);
	[viewheader addSubview:imageviewline3];
	
	UILabel *labelcode1 = [[UILabel alloc] initWithFrame:CGRectMake(0,imageviewline3.frame.origin.y, SCREEN_WIDTH/6, 40)];
	labelcode1.font = FONTN(13.0f);
	labelcode1.text = @"编号";
	labelcode1.textAlignment = NSTextAlignmentCenter;
	labelcode1.textColor = [UIColor whiteColor];
	labelcode1.backgroundColor = COLORNOW(254, 194, 84);
	[viewheader addSubview:labelcode1];
	
	UILabel *labelcode2 = [[UILabel alloc] initWithFrame:CGRectMake(labelcode1.frame.origin.x+labelcode1.frame.size.width,labelcode1.frame.origin.y, SCREEN_WIDTH/6+20, 40)];
	labelcode2.font = FONTN(13.0f);
	labelcode2.text = @"描述";
	labelcode2.textAlignment = NSTextAlignmentCenter;
	labelcode2.textColor = [UIColor whiteColor];
	labelcode2.backgroundColor = COLORNOW(254, 194, 84);
	[viewheader addSubview:labelcode2];
	
	UILabel *labelcode3 = [[UILabel alloc] initWithFrame:CGRectMake(labelcode2.frame.origin.x+labelcode2.frame.size.width,labelcode1.frame.origin.y, SCREEN_WIDTH/6-20, 40)];
	labelcode3.font = FONTN(12.0f);
	labelcode3.text = @"单位";
	labelcode3.textAlignment = NSTextAlignmentCenter;
	labelcode3.textColor = [UIColor whiteColor];
	labelcode3.backgroundColor = COLORNOW(254, 194, 84);
	[viewheader addSubview:labelcode3];
	
	UILabel *labelcode4 = [[UILabel alloc] initWithFrame:CGRectMake(labelcode3.frame.origin.x+labelcode3.frame.size.width,labelcode1.frame.origin.y, SCREEN_WIDTH/6, 40)];
	labelcode4.font = FONTN(12.0f);
	labelcode4.text = @"数量";
	labelcode4.textAlignment = NSTextAlignmentCenter;
	labelcode4.textColor = [UIColor whiteColor];
	labelcode4.backgroundColor = COLORNOW(254, 194, 84);
	[viewheader addSubview:labelcode4];
	
	UILabel *labelcode5 = [[UILabel alloc] initWithFrame:CGRectMake(labelcode4.frame.origin.x+labelcode4.frame.size.width,labelcode1.frame.origin.y, SCREEN_WIDTH/6, 40)];
	labelcode5.font = FONTN(12.0f);
	labelcode5.text = @"单价";
	labelcode5.textAlignment = NSTextAlignmentCenter;
	labelcode5.textColor = [UIColor whiteColor];
	labelcode5.backgroundColor = COLORNOW(254, 194, 84);
	[viewheader addSubview:labelcode5];
	
	UILabel *labelcode6 = [[UILabel alloc] initWithFrame:CGRectMake(labelcode5.frame.origin.x+labelcode5.frame.size.width,labelcode1.frame.origin.y, SCREEN_WIDTH/6, 40)];
	labelcode6.font = FONTN(12.0f);
	labelcode6.text = @"已发数";
	labelcode6.textAlignment = NSTextAlignmentCenter;
	labelcode6.textColor = [UIColor whiteColor];
	labelcode6.backgroundColor = COLORNOW(254, 194, 84);
	[viewheader addSubview:labelcode6];
	
	self.tableview.tableHeaderView = viewheader;
}

#pragma mark tableviewdelegate
//隐藏那些没有cell的线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

-(void)viewDidLayoutSubviews
{
	if ([self.tableview respondsToSelector:@selector(setSeparatorInset:)]) {
		[self.tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
	}
	
	if ([self.tableview respondsToSelector:@selector(setLayoutMargins:)]) {
		[self.tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
	}
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
		[cell setSeparatorInset:UIEdgeInsetsZero];
	}
	
	if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
		[cell setLayoutMargins:UIEdgeInsetsZero];
	}
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	return [arraydata count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
	static NSString *reuseIdetify = @"cell";
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
	for(UIView *view in cell.contentView.subviews)
	{
		[view removeFromSuperview];
	}
	
	cell.backgroundColor = [UIColor clearColor];
	
	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
	
	UILabel *labelcode1 = [[UILabel alloc] initWithFrame:CGRectMake(3,2, SCREEN_WIDTH/6-6, 36)];
	labelcode1.font = FONTN(12.0f);
	labelcode1.text = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"CommodityCode"]];
	labelcode1.textAlignment = NSTextAlignmentCenter;
	labelcode1.textColor = [UIColor blackColor];
	labelcode1.numberOfLines = 2;
	[cell.contentView addSubview:labelcode1];
	
	UILabel *labelcode2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/6+6,labelcode1.frame.origin.y, SCREEN_WIDTH/6+20-6, 36)];
	labelcode2.font = FONTN(12.0f);
	labelcode2.text = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"CommodityName"]];
	labelcode2.textAlignment = NSTextAlignmentCenter;
	labelcode2.textColor = [UIColor blackColor];
	labelcode2.numberOfLines = 2;
	[cell.contentView addSubview:labelcode2];
	
	UILabel *labelcode3 = [[UILabel alloc] initWithFrame:CGRectMake(labelcode2.frame.origin.x+labelcode2.frame.size.width+6,labelcode1.frame.origin.y, SCREEN_WIDTH/6-20-6, 36)];
	labelcode3.font = FONTN(12.0f);
	labelcode3.text = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"UnitofMeasurement"]];
	labelcode3.textAlignment = NSTextAlignmentCenter;
	labelcode3.textColor = [UIColor blackColor];
	labelcode3.numberOfLines = 2;
	[cell.contentView addSubview:labelcode3];
	
	UILabel *labelcode4 = [[UILabel alloc] initWithFrame:CGRectMake(labelcode3.frame.origin.x+labelcode3.frame.size.width+3,labelcode1.frame.origin.y, SCREEN_WIDTH/6-6, 36)];
	labelcode4.font = FONTN(12.0f);
	labelcode4.text = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"LNumber"]];
	labelcode4.textAlignment = NSTextAlignmentCenter;
	labelcode4.textColor = [UIColor blackColor];
	labelcode4.numberOfLines = 2;
	[cell.contentView addSubview:labelcode4];
	
	UILabel *labelcode5 = [[UILabel alloc] initWithFrame:CGRectMake(labelcode4.frame.origin.x+labelcode4.frame.size.width+6,labelcode1.frame.origin.y, SCREEN_WIDTH/6-6, 36)];
	labelcode5.font = FONTN(12.0f);
	labelcode5.text = [NSString stringWithFormat:@"￥%@",[dictemp objectForKey:@"Price"]];
	labelcode5.textAlignment = NSTextAlignmentCenter;
	labelcode5.numberOfLines = 2;
	labelcode5.textColor = [UIColor blackColor];
	[cell.contentView addSubview:labelcode5];
	
	UILabel *labelcode6 = [[UILabel alloc] initWithFrame:CGRectMake(labelcode5.frame.origin.x+labelcode5.frame.size.width+6,labelcode1.frame.origin.y, SCREEN_WIDTH/6-6, 36)];
	labelcode6.font = FONTN(12.0f);
	labelcode6.text = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"DeliveryNumber"]];
	labelcode6.textAlignment = NSTextAlignmentCenter;
	labelcode6.textColor = [UIColor blackColor];
	labelcode6.numberOfLines = 2;
	[cell.contentView addSubview:labelcode6];
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
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