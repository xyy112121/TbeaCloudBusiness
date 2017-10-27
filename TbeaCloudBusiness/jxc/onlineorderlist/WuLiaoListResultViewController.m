//
//  WuLiaoListResultViewController.m
//  TeBian
//
//  Created by xyy520 on 16/1/7.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "WuLiaoListResultViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "RequestInterface.h"

#import "JQIndicatorView.h"
#import "UIImageView+AFNetworking.h"
#import "AddInterface.h"
@interface WuLiaoListResultViewController ()

@end

@implementation WuLiaoListResultViewController
@synthesize delegate1;
@synthesize delegate2;

-(void)returnback:(id)sender
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	JQIndicatorView *indicator = [app.window viewWithTag:IndicatorTag];
	[indicator stopAnimating];
	[self.navigationController popViewControllerAnimated:YES];
}


-(void) requestwuliaolist:(NSString *)page Pagesize:(NSString *)pagesize Pcode:(NSString *)pcode Pname:(NSString *)pname Pdes:(NSString *)pdes
{
	
	NSDictionary *parameters =  @{@"ProductCode":pcode,@"ProductName":pname,@"ProductDescription":pdes,@"Page":page,@"PageSize":pagesize};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA07030700" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 arraydata = [responseObject objectForKey:@"ProductList"];
		 self.tableview.delegate = self;
		 self.tableview.dataSource = self;
		 [self.tableview reloadData];
         [self.tableview.mj_header endRefreshing];
         [self.tableview.mj_footer endRefreshing];
	 }];
	
}


-(void)headerview:(NSString *)sender
{
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
	viewheader.backgroundColor = [UIColor whiteColor];
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 20)];
	label.backgroundColor = [UIColor clearColor];
	label.textAlignment = NSTextAlignmentCenter;
	label.textColor = COLORNOW(129, 129, 129);
	label.font = FONTN(13.0f);
	NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共为你查询到%@条结果记录",sender]];
	NSRange contentRange = {6,1};
	[content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
	[content addAttribute:NSUnderlineColorAttributeName value:COLORNOW(0, 51, 153) range:contentRange];
	[content addAttribute:NSForegroundColorAttributeName value:COLORNOW(0, 51, 153) range:contentRange];
	label.attributedText = content;
	[viewheader addSubview:label];
	
	self.tableview.tableHeaderView = viewheader;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"选择添加物料";
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
    
	//	[self headerview:nil];
	[self requestwuliaolist:@"1" Pagesize:@"10" Pcode:self.strpcode Pname:self.strpname Pdes:self.strpdes];
    
    __weak __typeof(self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestwuliaolist:@"1" Pagesize:@"10" Pcode:self.strpcode Pname:self.strpname Pdes:self.strpdes];
    }];
    
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestwuliaolist:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10] Pcode:self.strpcode Pname:self.strpname Pdes:self.strpdes];
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
	return 120;
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
	NSDictionary *dictemp  = [arraydata objectAtIndex:indexPath.row];
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 110)];
	imageview.backgroundColor = COLORNOW(252, 252, 252);
	imageview.layer.cornerRadius = 2.0f;
	imageview.clipsToBounds = YES;
	imageview.layer.shadowColor = COLORNOW(42, 42, 42).CGColor;
	imageview.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
	imageview.layer.shadowOpacity = 1.0;//不透明度
	imageview.layer.shadowRadius = 5.0;//半径
	[cell.contentView addSubview:imageview];
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+5, 15, 55, 20)];
	labeltitle.font = FONTN(12.0f);
	labeltitle.text = @"产品编码:";
	labeltitle.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labeltitle];
	
	UILabel *labelcode = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x+labeltitle.frame.size.width+5, 15, 200, 20)];
	labelcode.font = FONTN(12.0f);
	labelcode.text = [dictemp objectForKey:@"ProductCode"];
	labelcode.textColor = COLORNOW(51, 51, 51);
	[cell.contentView addSubview:labelcode];
	
	UIButton *buttonadd = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonadd.frame = CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-40,10, 30, 30);
	buttonadd.layer.cornerRadius = 15.0f;
	buttonadd.clipsToBounds = YES;
	buttonadd.tag = 1400+indexPath.row;
	[buttonadd setImage:LOADIMAGE(@"addwuliaoicon", @"png") forState:UIControlStateNormal];
	[buttonadd addTarget:self action:@selector(gotoaddwuliao:) forControlEvents:UIControlEventTouchUpInside];
	[cell.contentView addSubview:buttonadd];
	
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x, 40, imageview.frame.size.width, 0.5)];
	imageviewline.backgroundColor = COLORNOW(211, 211, 211);
	[cell.contentView addSubview:imageviewline];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x,imageviewline.frame.origin.y+10, 200, 20)];
	labelname.font = FONTN(12.0f);
	labelname.text = [NSString stringWithFormat:@"产品名称:  %@",[dictemp objectForKey:@"ProductName"]];;
	labelname.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelname];
	
	UILabel *labelunit = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-80,labelname.frame.origin.y, 70, 20)];
	labelunit.font = FONTN(12.0f);
	labelunit.text =  [NSString stringWithFormat:@"单位 %@",[dictemp objectForKey:@"UnitofMeasurement"]];// @"单位:KM";
	labelunit.textColor = COLORNOW(151, 151, 151);
	labelunit.textAlignment = NSTextAlignmentRight;
	[cell.contentView addSubview:labelunit];
	
	UIImageView *imageviewline1 = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x,imageviewline.frame.origin.y+40, imageview.frame.size.width, 0.5)];
	imageviewline1.backgroundColor = COLORNOW(211, 211, 211);
	[cell.contentView addSubview:imageviewline1];
	
	UILabel *labeldes = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x,imageviewline1.frame.origin.y+10, 260, 20)];
	labeldes.font = FONTN(12.0f);
	labeldes.text = [NSString stringWithFormat:@"产品描述:  %@",[dictemp objectForKey:@"ProductDescription"]];;
	labeldes.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labeldes];
	
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

-(void)gotoaddwuliao:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag]-1400;
	NSDictionary *dictemp = [arraydata objectAtIndex:tagnow];
	if([delegate1 respondsToSelector:@selector(updateselectwuliao:)])
	{
		
		if([delegate2 respondsToSelector:@selector(addreturnflag:)])
		{
			[delegate2 addreturnflag:1];
		}
		
		[delegate1 updateselectwuliao:dictemp];
		[self.navigationController popViewControllerAnimated:YES];
	}
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
