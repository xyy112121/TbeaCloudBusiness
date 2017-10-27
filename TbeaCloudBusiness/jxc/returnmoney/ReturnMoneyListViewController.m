//
//  ReturnMoneyListViewController.m
//  TeBian
//
//  Created by xyy520 on 15/12/15.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import "ReturnMoneyListViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "RequestInterface.h"

#import "JQIndicatorView.h"
#import "UIImageView+AFNetworking.h"
#import "AddInterface.h"
#import "ReturnSearchViewController.h"
#import "ReturnMoneyDetailViewController.h"
@interface ReturnMoneyListViewController ()

@end

@implementation ReturnMoneyListViewController
-(void)returnback:(id)sender
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	JQIndicatorView *indicator = [app.window viewWithTag:IndicatorTag];
	[indicator stopAnimating];
	[self.navigationController popViewControllerAnimated:YES];
}


-(void) requestJXReturnmoneylist:(NSString *)page Pagesize:(NSString *)pagesize
{
	
	NSDictionary *parameters = @{@"Page": page,@"PageSize":pagesize};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA08010000" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 [self headerview:[responseObject objectForKey:@"TotleInfo"]];
		 arraydata = [responseObject objectForKey:@"OrderList"];
		 self.tableview.delegate =self;
		 self.tableview.dataSource = self;
		 [self.tableview reloadData];
         [self.tableview.mj_header endRefreshing];
         [self.tableview.mj_footer endRefreshing];
	 }];
	
}

-(void)headerview:(NSDictionary *)sender
{
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
	viewheader.backgroundColor = [UIColor whiteColor];
	
	UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 20, 72, 26)];
	imageview1.image = LOADIMAGE(@"订货总金额", @"png");
	[viewheader addSubview:imageview1];
	
	UILabel *labelmoney1 = [[UILabel alloc] initWithFrame:CGRectMake(imageview1.frame.origin.x+30,imageview1.frame.origin.y+11, 90, 20)];
	labelmoney1.font = FONTN(11.0f);
	labelmoney1.text = [NSString stringWithFormat:@"￥%@",[sender objectForKey:@"TotleOrderMoney"]];
	labelmoney1.textColor = COLORNOW(255, 102, 0);
	[viewheader addSubview:labelmoney1];
	
	
	UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-130, 20, 73, 28)];
	imageview2.image = LOADIMAGE(@"已发货金额", @"png");
	[viewheader addSubview:imageview2];
	
	UILabel *labelmoney2 = [[UILabel alloc] initWithFrame:CGRectMake(imageview2.frame.origin.x+30,imageview2.frame.origin.y+11, 90, 20)];
	labelmoney2.font = FONTN(11.0f);
	labelmoney2.text = [NSString stringWithFormat:@"￥%@",[sender objectForKey:@"TotleDeliveryMoney"]];
	labelmoney2.textColor = COLORNOW(0, 153, 204);
	[viewheader addSubview:labelmoney2];
	
	UIImageView *imageview3 = [[UIImageView alloc] initWithFrame:CGRectMake(imageview1.frame.origin.x, 60, 73, 27)];
	imageview3.image = LOADIMAGE(@"回款总经额", @"png");
	[viewheader addSubview:imageview3];
	
	UILabel *labelmoney3 = [[UILabel alloc] initWithFrame:CGRectMake(imageview3.frame.origin.x+30,imageview3.frame.origin.y+11, 90, 20)];
	labelmoney3.font = FONTN(11.0f);
	labelmoney3.text = [NSString stringWithFormat:@"￥%@",[sender objectForKey:@"TotleReceivedMoney"]];
	labelmoney3.textColor = COLORNOW(102, 153, 0);
	[viewheader addSubview:labelmoney3];
	
	UIImageView *imageview4 = [[UIImageView alloc] initWithFrame:CGRectMake(imageview2.frame.origin.x, 60, 72, 26)];
	imageview4.image = LOADIMAGE(@"应收款金额", @"png");
	[viewheader addSubview:imageview4];
	
	UILabel *labelmoney4 = [[UILabel alloc] initWithFrame:CGRectMake(imageview4.frame.origin.x+30,imageview4.frame.origin.y+11, 90, 20)];
	labelmoney4.font = FONTN(11.0f);
	labelmoney4.text = [NSString stringWithFormat:@"￥%@",[sender objectForKey:@"TotleLeftMoney"]];
	labelmoney4.textColor = COLORNOW(204, 204, 204);
	[viewheader addSubview:labelmoney4];
	
	self.tableview.tableHeaderView = viewheader;
}

-(void)gotosearch:(id)sender
{
    ReturnSearchViewController *moneysearch = [[ReturnSearchViewController alloc] init];
	moneysearch.delegate1 = self;
	[self.navigationController pushViewController:moneysearch animated:YES];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	
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
	
//	UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
//	UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
//	[buttonright setImage:LOADIMAGE(@"jxsearchicon", @"png") forState:UIControlStateNormal];
//	buttonright.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
//	[buttonright addTarget:self action: @selector(gotosearch:) forControlEvents: UIControlEventTouchUpInside];
//	[contentViewright addSubview:buttonright];
//	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
//	self.navigationItem.rightBarButtonItem = barButtonItemright;
	
	[self requestJXReturnmoneylist:@"1" Pagesize:@"10"];
    
    __weak __typeof(self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestJXReturnmoneylist:@"1" Pagesize:@"10"];
    }];
    
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestJXReturnmoneylist:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10]];
    }];
    
	// Do any additional setup after loading the view.
}


#pragma mark tableviewdelegate
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
	return 140;
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
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 130)];
	imageview.backgroundColor = COLORNOW(252, 252, 252);
	imageview.layer.cornerRadius = 2.0f;
	imageview.clipsToBounds = YES;
	imageview.layer.shadowColor = COLORNOW(42, 42, 42).CGColor;
	imageview.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
	imageview.layer.shadowOpacity = 1.0;//不透明度
	imageview.layer.shadowRadius = 5.0;//半径
	[cell.contentView addSubview:imageview];
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+5, 15, 200, 20)];
	labeltitle.font = FONTB(12.0f);
	labeltitle.text = [dictemp objectForKey:@"CustomerName"];
	labeltitle.textColor = COLORNOW(102, 102, 102);
	[cell.contentView addSubview:labeltitle];
	
	UILabel *labelID = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-105,15, 100, 20)];
	labelID.font = FONTN(12.0f);
	labelID.text = [dictemp objectForKey:@"OrderDate"];
	labelID.textAlignment = NSTextAlignmentRight;
	labelID.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelID];
	
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x, 40, imageview.frame.size.width, 0.5)];
	imageviewline.backgroundColor = COLORNOW(211, 211, 211);
	[cell.contentView addSubview:imageviewline];
	
	UILabel *labelunit = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x,imageviewline.frame.origin.y+5, 160, 20)];
	labelunit.font = FONTN(12.0f);
	labelunit.text =[dictemp objectForKey:@"OrderCode"];
	labelunit.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelunit];
	
	NSString *strprice = [NSString stringWithFormat:@"￥%@",[dictemp objectForKey:@"OrderMoney"]];
	NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12.0f],NSFontAttributeName, nil];
	CGSize size = [strprice boundingRectWithSize:CGSizeMake(150, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
	
	UILabel *labelstocknum = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-size.width-5,imageviewline.frame.origin.y+5, size.width, 20)];
	labelstocknum.font = FONTN(12.0f);
	labelstocknum.text = [NSString stringWithFormat:@"￥%@",[dictemp objectForKey:@"OrderMoney"]];
	labelstocknum.textAlignment = NSTextAlignmentRight;
	labelstocknum.textColor = COLORNOW(255, 102, 0);
	[cell.contentView addSubview:labelstocknum];
	
	UILabel *labelstock = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-size.width-55,imageviewline.frame.origin.y+5, 50, 20)];
	labelstock.font = FONTN(12.0f);
	labelstock.text = @"订单总额";
	labelstock.textAlignment = NSTextAlignmentRight;
	labelstock.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelstock];
	

	
	UIImageView *imageviewline1 = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x, 70, imageview.frame.size.width, 0.5)];
	imageviewline1.backgroundColor = COLORNOW(211, 211, 211);
	[cell.contentView addSubview:imageviewline1];
	
	UILabel *labelyifa = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x,imageviewline1.frame.origin.y+5, 60, 20)];
	labelyifa.font = FONTN(12.0f);
	labelyifa.text = @"已发货金额";
	labelyifa.textAlignment = NSTextAlignmentRight;
	labelyifa.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelyifa];
	
	UILabel *labelyifanum = [[UILabel alloc] initWithFrame:CGRectMake(labelyifa.frame.origin.x+labelyifa.frame.size.width+30,labelyifa.frame.origin.y, 150, 20)];
	labelyifanum.font = FONTN(12.0f);
	labelyifanum.text = [NSString stringWithFormat:@"￥%@",[dictemp objectForKey:@"DeliveryMoney"]];
	labelyifanum.textColor = COLORNOW(102, 153, 0);
	[cell.contentView addSubview:labelyifanum];
	
	UILabel *labelyihui = [[UILabel alloc] initWithFrame:CGRectMake(labelyifa.frame.origin.x,labelyifa.frame.origin.y+labelyifa.frame.size.height, 60, 20)];
	labelyihui.font = FONTN(12.0f);
	labelyihui.text = @"已回款金额";
	labelyihui.textAlignment = NSTextAlignmentRight;
	labelyihui.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelyihui];
	
	UILabel *labelyihuinum = [[UILabel alloc] initWithFrame:CGRectMake(labelyihui.frame.origin.x+labelyihui.frame.size.width+30,labelyihui.frame.origin.y, 150, 20)];
	labelyihuinum.font = FONTN(12.0f);
	labelyihuinum.text = [NSString stringWithFormat:@"￥%@",[dictemp objectForKey:@"ReceivedMoney"]];
	labelyihuinum.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelyihuinum];
	
	UILabel *labelyingshou = [[UILabel alloc] initWithFrame:CGRectMake(labelyihui.frame.origin.x,labelyihui.frame.origin.y+labelyihui.frame.size.height, 60, 20)];
	labelyingshou.font = FONTN(12.0f);
	labelyingshou.text = @"应 收 余 额";
	labelyingshou.textAlignment = NSTextAlignmentRight;
	labelyingshou.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelyingshou];
	
	UILabel *labelyingshounum = [[UILabel alloc] initWithFrame:CGRectMake(labelyingshou.frame.origin.x+labelyingshou.frame.size.width+30,labelyingshou.frame.origin.y, 150, 20)];
	labelyingshounum.font = FONTN(12.0f);
	labelyingshounum.text = [NSString stringWithFormat:@"￥%@",[dictemp objectForKey:@"LeftMoney"]];
	labelyingshounum.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelyingshounum];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *dicmessage = [arraydata objectAtIndex:indexPath.row];
    ReturnMoneyDetailViewController *detail = [[ReturnMoneyDetailViewController alloc] init];
	detail.strorderid = [dicmessage objectForKey:@"Id"];
	[self.navigationController pushViewController:detail animated:YES];
	
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
