//
//  PerferentialsSupportViewController.m
//  TeBian
//
//  Created by xyy520 on 15/12/16.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import "PerferentialsSupportViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "RequestInterface.h"

#import "JQIndicatorView.h"
#import "UIImageView+AFNetworking.h"
#import "AddInterface.h"

@interface PerferentialsSupportViewController ()

@end

@implementation PerferentialsSupportViewController
-(void)returnback:(id)sender
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	JQIndicatorView *indicator = [app.window viewWithTag:IndicatorTag];
	[indicator stopAnimating];
	[self.navigationController popViewControllerAnimated:YES];
}


-(void) requestJXperferentlist:(NSString *)page Pagesize:(NSString *)pagesize
{
	
	NSDictionary *parameters = @{@"Page": page,@"PageSize":pagesize};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA10010000" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 NSDictionary *dictop = [responseObject objectForKey:@"TotleInfo"];
		 UILabel *label1 = [self.tableview.tableHeaderView viewWithTag:200];
		 UILabel *label2 = [self.tableview.tableHeaderView viewWithTag:201];
		 UILabel *label3 = [self.tableview.tableHeaderView viewWithTag:202];
		 UILabel *label4 = [self.tableview.tableHeaderView viewWithTag:203];
		 
		 label1.text = [dictop objectForKey:@"CompanyName"];
		 label2.text = [dictop objectForKey:@"Date"];
		 label3.text = [NSString stringWithFormat:@"￥%@",[dictop objectForKey:@"ShouldRebateFee"]];
		 label4.text = [NSString stringWithFormat:@"￥%@",[dictop objectForKey:@"RebatedFee"]];
		 arraydata = [responseObject objectForKey:@"RebatedList"];
		 dictotleinfo = [responseObject objectForKey:@"TotleInfo"];
		 if([arraydata count]>0)
		 {
			 self.tableview.delegate = self;
			 self.tableview.dataSource = self;
			 [self.tableview reloadData];
			 
		 }
         [self.tableview.mj_header endRefreshing];
         [self.tableview.mj_footer endRefreshing];
	 }];
	
}

-(void) requestJXperferentlist1:(NSString *)page Pagesize:(NSString *)pagesize
{

	
	NSDictionary *parameters = @{@"Page": page,@"PageSize":pagesize};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA10020000" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 NSDictionary *dictop = [responseObject objectForKey:@"TotleInfo"];
		 UILabel *label1 = [self.tableview.tableHeaderView viewWithTag:200];
		 UILabel *label2 = [self.tableview.tableHeaderView viewWithTag:201];
		 UILabel *label3 = [self.tableview.tableHeaderView viewWithTag:202];
		 UILabel *label4 = [self.tableview.tableHeaderView viewWithTag:203];
		 
		 label1.text = [dictop objectForKey:@"CompanyName"];
		 label2.text = [dictop objectForKey:@"Date"];
		 label3.text = [NSString stringWithFormat:@"￥%@",[dictop objectForKey:@"ShouldRebateFee"]];
		 label4.text = [NSString stringWithFormat:@"￥%@",[dictop objectForKey:@"RebatedFee"]];
		 arraydata = [responseObject objectForKey:@"ShouldRebateList"];
		 if([arraydata count]>0)
		 {
			 self.tableview.delegate = self;
			 self.tableview.dataSource = self;
			 [self.tableview reloadData];
			 
		 }
         [self.tableview.mj_header endRefreshing];
         [self.tableview.mj_footer endRefreshing];
	 }];
	
}

-(void)headerview:(NSString *)sender
{
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
	viewheader.backgroundColor = [UIColor whiteColor];
	
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
	labelname.font = FONTN(12.0f);
	labelname.text = @"";
	labelname.tag = 200;
	labelname.textColor = COLORNOW(51, 51, 51);
	[viewheader addSubview:labelname];

	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-115,10, 110, 20)];
	labeltime.font = FONTN(12.0f);
	labeltime.text = @"";
	labeltime.tag = 201;
	labeltime.textAlignment = NSTextAlignmentRight;
	labeltime.textColor = COLORNOW(151, 151, 151);
	[viewheader addSubview:labeltime];

	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 0.5)];
	imageviewline.backgroundColor = COLORNOW(211, 211, 211);
	[viewheader addSubview:imageviewline];
	
	UILabel *labelmoney = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x,imageviewline.frame.origin.y+10, 80, 20)];
	labelmoney.font = FONTN(12.0f);
	labelmoney.text = @"应返利金额";
	labelmoney.textAlignment = NSTextAlignmentRight;
	labelmoney.textColor = COLORNOW(151, 151, 151);
	[viewheader addSubview:labelmoney];
	
	UILabel *labelmoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(labelmoney.frame.origin.x+labelmoney.frame.size.width+5,labelmoney.frame.origin.y, 120, 20)];
	labelmoneyvalue.font = FONTN(12.0f);
	labelmoneyvalue.text =  @"";
	labelmoneyvalue.tag = 202;
	labelmoneyvalue.textColor = COLORNOW(255, 102, 0);
	[viewheader addSubview:labelmoneyvalue];
	
	UILabel *labelyimoney = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+10,labelmoney.frame.origin.y, 80, 20)];
	labelyimoney.font = FONTN(12.0f);
	labelyimoney.text = @"已返利金额";
	labelyimoney.textAlignment = NSTextAlignmentRight;
	labelyimoney.textColor = COLORNOW(151, 151, 151);
	[viewheader addSubview:labelyimoney];
	
	UILabel *labelyimoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(labelyimoney.frame.origin.x+labelyimoney.frame.size.width+5,labelyimoney.frame.origin.y, 120, 20)];
	labelyimoneyvalue.font = FONTN(12.0f);
	labelyimoneyvalue.text =  @"";
	labelyimoneyvalue.tag = 203;
	labelyimoneyvalue.textColor = [UIColor greenColor];
	[viewheader addSubview:labelyimoneyvalue];
	
	UIImageView *imageviewline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 0.5)];
	imageviewline1.backgroundColor = COLORNOW(211, 211, 211);
	[viewheader addSubview:imageviewline1];
	
	UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
	button1.frame = CGRectMake((SCREEN_WIDTH-160-20)/2,imageviewline1.frame.origin.y+1, 80, 39);
	button1.tag = 260;
	button1.titleLabel.font = FONTN(13.0f);
	button1.clipsToBounds = YES;
	[button1 setTitle:@"应返明细" forState:UIControlStateNormal];
	[button1 setTitleColor:COLORNOW(51, 51, 51) forState:UIControlStateNormal];
	[button1 addTarget:self action:@selector(clicktag:) forControlEvents:UIControlEventTouchUpInside];
	[viewheader addSubview:button1];
	
	UIImageView *imageviewline2 = [[UIImageView alloc] initWithFrame:CGRectMake(button1.frame.origin.x, button1.frame.origin.y+button1.frame.size.height-2, button1.frame.size.width, 2)];
	imageviewline2.backgroundColor = COLORNOW(19, 50, 128);
	imageviewline2.alpha = 1;
	imageviewline2.tag = 910;
	[viewheader addSubview:imageviewline2];
	
	UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
	button2.frame = CGRectMake(SCREEN_WIDTH/2+10,imageviewline1.frame.origin.y+1,80, 39);
	button2.tag = 261;
	button2.titleLabel.font = FONTN(13.0f);
	button2.clipsToBounds = YES;
	[button2 setTitle:@"已返明细" forState:UIControlStateNormal];
	[button2 setTitleColor:COLORNOW(151, 151, 151) forState:UIControlStateNormal];
	[button2 addTarget:self action:@selector(clicktag:) forControlEvents:UIControlEventTouchUpInside];
	[viewheader addSubview:button2];
	
	UIImageView *imageviewline3 = [[UIImageView alloc] initWithFrame:CGRectMake(button2.frame.origin.x, button2.frame.origin.y+button2.frame.size.height-2, button2.frame.size.width, 2)];
	imageviewline3.backgroundColor = COLORNOW(19, 50, 128);
	imageviewline3.alpha = 0;
	imageviewline3.tag = 911;
	[viewheader addSubview:imageviewline3];
	
	self.tableview.tableHeaderView = viewheader;
}

-(void)clicktag:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag]-260;
	UIImageView *imageview1 = [self.tableview.tableHeaderView viewWithTag:910];
	UIImageView *imageview2 = [self.tableview.tableHeaderView viewWithTag:911];
	UIButton *button1 = [self.tableview.tableHeaderView viewWithTag:260];
	UIButton *button2 = [self.tableview.tableHeaderView viewWithTag:261];
	if(tagnow == 0)
	{
		imageview1.alpha = 1;
		imageview2.alpha = 0;
		[button1 setTitleColor:COLORNOW(51, 51, 51) forState:UIControlStateNormal];
		[button2 setTitleColor:COLORNOW(151, 151, 151) forState:UIControlStateNormal];
		selectmodel = 0;
		[self requestJXperferentlist:@"1" Pagesize:@"10"];
	}
	else
	{
		imageview1.alpha = 0;
		imageview2.alpha = 1;
		[button2 setTitleColor:COLORNOW(51, 51, 51) forState:UIControlStateNormal];
		[button1 setTitleColor:COLORNOW(151, 151, 151) forState:UIControlStateNormal];
		selectmodel = 1;
		[self requestJXperferentlist1:@"1" Pagesize:@"10"];
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"返利";
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
    
	[self headerview:nil];
//	strsearchname = @"";
	selectmodel = 0;
	[self requestJXperferentlist:@"1" Pagesize:@"10"];
    
    __weak __typeof(self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if(selectmodel == 0)
            [weakSelf requestJXperferentlist:@"1" Pagesize:@"10"];
        else
            [weakSelf requestJXperferentlist1:@"1" Pagesize:@"10"];
    }];
    
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if(selectmodel == 0)
            [weakSelf requestJXperferentlist:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10]];
        else
            [weakSelf requestJXperferentlist1:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10]];
        
    }];
    
	// Do any additional setup after loading the view.
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
	return 70;
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
	
	if(selectmodel== 0)
	{
		NSDictionary *dictemp  = [arraydata objectAtIndex:indexPath.row];
		UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 60)];
		imageview.backgroundColor = COLORNOW(252, 252, 252);
		imageview.layer.cornerRadius = 2.0f;
		imageview.clipsToBounds = YES;
		imageview.layer.shadowColor = COLORNOW(42, 42, 42).CGColor;
		imageview.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
		imageview.layer.shadowOpacity = 1.0;//不透明度
		imageview.layer.shadowRadius = 5.0;//半径
		[cell.contentView addSubview:imageview];
		
//		UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+5, 15, 55, 20)];
//		labeltitle.font = FONTN(12.0f);
//		labeltitle.text = @"订单号:";
//		labeltitle.textColor = COLORNOW(151, 151, 151);
//		[cell.contentView addSubview:labeltitle];
//		
		UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+5, 15, 200, 20)];
		labelname.font = FONTN(12.0f);
		labelname.text = [dictemp objectForKey:@"RebatedName"];
		labelname.textColor = COLORNOW(255, 102, 0);
		[cell.contentView addSubview:labelname];
		
		UILabel *labelID = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-115,15, 110, 20)];
		labelID.font = FONTN(12.0f);
		labelID.text = [dictemp objectForKey:@"RebateStatus"];// @"ID:30234562";
		labelID.textAlignment = NSTextAlignmentRight;
		labelID.textColor = COLORNOW(255, 102, 0);
		[cell.contentView addSubview:labelID];
		
		UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x, 40, imageview.frame.size.width, 0.5)];
		imageviewline.backgroundColor = COLORNOW(211, 211, 211);
		[cell.contentView addSubview:imageviewline];
		
		NSString *money = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"RebateFee"]];
		NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12.0f],NSFontAttributeName, nil];
		
		CGSize size = [money boundingRectWithSize:CGSizeMake(300, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
		
		UILabel *labelunit = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-size.width-20,imageviewline.frame.origin.y+5, size.width+15, 20)];
		labelunit.font = FONTN(12.0f);
		labelunit.text =  [NSString stringWithFormat:@"￥%@",[dictemp objectForKey:@"RebateFee"]];// @"单位:KM";
		labelunit.textColor = COLORNOW(255, 102, 0);
		[cell.contentView addSubview:labelunit];
		
		UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(labelunit.frame.origin.x-58, labelunit.frame.origin.y, 58, 20)];
		labeltitle.font = FONTN(12.0f);
		labeltitle.text = @"返利金额:";
		labeltitle.textColor = COLORNOW(151, 151, 151);
		[cell.contentView addSubview:labeltitle];
		
	}
	else if(selectmodel== 1)
	{
		NSDictionary *dictemp  = [arraydata objectAtIndex:indexPath.row];
		UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 60)];
		imageview.backgroundColor = COLORNOW(252, 252, 252);
		imageview.layer.cornerRadius = 2.0f;
		imageview.clipsToBounds = YES;
		imageview.layer.shadowColor = COLORNOW(42, 42, 42).CGColor;
		imageview.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
		imageview.layer.shadowOpacity = 1.0;//不透明度
		imageview.layer.shadowRadius = 5.0;//半径
		[cell.contentView addSubview:imageview];
		
		UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+5, 15, 45, 20)];
		labeltitle.font = FONTN(12.0f);
		labeltitle.text = @"订单号:";
		labeltitle.textColor = COLORNOW(151, 151, 151);
		[cell.contentView addSubview:labeltitle];
		//
		UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x+labeltitle.frame.size.width, 15, 200, 20)];
		labelname.font = FONTN(12.0f);
		labelname.text = [dictemp objectForKey:@"OrderCode"];
		labelname.textColor = COLORNOW(151, 151, 151);
		[cell.contentView addSubview:labelname];
		
		UILabel *labelID = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-115,15, 110, 20)];
		labelID.font = FONTN(12.0f);
		labelID.text = [dictemp objectForKey:@"RebateStatus"];// @"ID:30234562";
		labelID.textAlignment = NSTextAlignmentRight;
		labelID.textColor = COLORNOW(255, 102, 0);
		[cell.contentView addSubview:labelID];
		
		UILabel *labelstatus = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-115,15, 110, 20)];
		labelstatus.font = FONTN(12.0f);
		labelstatus.text = [dictemp objectForKey:@"RebateStatus"];
		labelstatus.textAlignment = NSTextAlignmentRight;
		labelstatus.textColor = [UIColor greenColor];
		[cell.contentView addSubview:labelstatus];
		
		UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x, 40, imageview.frame.size.width, 0.5)];
		imageviewline.backgroundColor = COLORNOW(211, 211, 211);
		[cell.contentView addSubview:imageviewline];
		
		UILabel *labelfee = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x,imageviewline.frame.origin.y+5, 110, 20)];
		labelfee.font = FONTN(12.0f);
		labelfee.text = [NSString stringWithFormat:@"订单金额: ￥%@",[dictemp objectForKey:@"OrderMoney"]];
		labelfee.textColor = COLORNOW(151, 151, 151);
		[cell.contentView addSubview:labelfee];
		
		NSString *money = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"RebateFee"]];
		NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12.0f],NSFontAttributeName, nil];
		
		CGSize size = [money boundingRectWithSize:CGSizeMake(300, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
		
		UILabel *labelunit = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-size.width-20,imageviewline.frame.origin.y+5, size.width+15, 20)];
		labelunit.font = FONTN(12.0f);
		labelunit.text =  [NSString stringWithFormat:@"￥%@",[dictemp objectForKey:@"RebateFee"]];// @"单位:KM";
		labelunit.textColor = [UIColor greenColor];
		[cell.contentView addSubview:labelunit];
		
		UILabel *labelreturntitle = [[UILabel alloc] initWithFrame:CGRectMake(labelunit.frame.origin.x-58, labelunit.frame.origin.y, 58, 20)];
		labelreturntitle.font = FONTN(12.0f);
		labelreturntitle.text = @"返利金额:";
		labelreturntitle.textColor = COLORNOW(151, 151, 151);
		[cell.contentView addSubview:labelreturntitle];
		
	}
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//	NSDictionary *dicmessage = [self.arraymessage objectAtIndex:indexPath.row];
	//	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	//	MessageDetailViewController *detail = [storyboard instantiateViewControllerWithIdentifier:@"MessageDetailViewController"];
	//	detail.hidesBottomBarWhenPushed = YES;
	//	detail.strmessgeid = [dicmessage objectForKey:@"Id"];
	//	[self.navigationController pushViewController:detail animated:YES];
	
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
