//
//  OnlineComplaintViewController.m
//  TeBian
//
//  Created by xyy520 on 15/12/16.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import "OnlineComplaintViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "RequestInterface.h"

#import "JQIndicatorView.h"
#import "UIImageView+AFNetworking.h"
#import "AddInterface.h"
#import "SendComplainViewController.h"
#import "OnlineComplainDetailViewController.h"
@interface OnlineComplaintViewController ()

@end

@implementation OnlineComplaintViewController

-(void)returnback:(id)sender
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	JQIndicatorView *indicator = [app.window viewWithTag:IndicatorTag];
	[indicator stopAnimating];
	[self.navigationController popViewControllerAnimated:YES];
}

//消息列表
-(void) requestJXonlinelist:(NSString *)page Pagesize:(NSString *)pagesize
{

	
	NSDictionary *parameters = @{@"Page": page,@"PageSize":pagesize};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA14020000" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 arraydata = [responseObject objectForKey:@"ComplainList"];
		 self.tableview.delegate = self;
		 self.tableview.dataSource = self;
		 [self.tableview reloadData];
         [self.tableview.mj_header endRefreshing];
         [self.tableview.mj_footer endRefreshing];
	 }];
	
	
}


-(void)gotosendcomplain:(id)sender
{
    SendComplainViewController *complain = [[SendComplainViewController alloc] init];
	complain.delegate1 = self;
	[self.navigationController pushViewController:complain animated:YES];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"投诉纪录";
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
	[buttonright setImage:LOADIMAGE(@"complain", @"png") forState:UIControlStateNormal];
	buttonright.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
	[buttonright addTarget:self action: @selector(gotosendcomplain:) forControlEvents: UIControlEventTouchUpInside];
	[contentViewright addSubview:buttonright];
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
	self.navigationItem.rightBarButtonItem = barButtonItemright;
	
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-40)];
    self.tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableview];
    [self setExtraCellLineHidden:self.tableview];
	
    __weak __typeof(self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestJXonlinelist:@"1" Pagesize:@"10"];
    }];
    
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestJXonlinelist:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10]];
    }];
    
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
	[self requestJXonlinelist:@"1" Pagesize:@"10"];
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
	
	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 110)];
	imageview.backgroundColor = COLORNOW(252, 252, 252);
	imageview.layer.cornerRadius = 2.0f;
	imageview.clipsToBounds = YES;
	imageview.layer.shadowColor = COLORNOW(42, 42, 42).CGColor;
	imageview.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
	imageview.layer.shadowOpacity = 1.0;//不透明度
	imageview.layer.shadowRadius = 5.0;//半径
	[cell.contentView addSubview:imageview];
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+5, 15, 155, 20)];
	labeltitle.font = FONTN(12.0f);
	labeltitle.text = [dictemp objectForKey:@"Date"];
	labeltitle.textColor = COLORNOW(51, 51, 51);
	[cell.contentView addSubview:labeltitle];
	
	UILabel *labelID = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-85,15, 80, 20)];
	labelID.font = FONTN(12.0f);
	labelID.text = [dictemp objectForKey:@"ComplainStatus"];
	labelID.textAlignment = NSTextAlignmentRight;
	labelID.textColor = COLORNOW(204, 153, 0);
	[cell.contentView addSubview:labelID];
	
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x, 40, imageview.frame.size.width, 0.5)];
	imageviewline.backgroundColor = COLORNOW(211, 211, 211);
	[cell.contentView addSubview:imageviewline];
	
	UILabel *labelunit = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x,imageviewline.frame.origin.y+5, 220, 16)];
	labelunit.font = FONTN(12.0f);
	labelunit.text =  [NSString stringWithFormat:@"联系电话:%@",[dictemp objectForKey:@"ContactMobile"]];
	labelunit.textColor = COLORNOW(51, 51, 51);
	[cell.contentView addSubview:labelunit];
	
	UILabel *labelstock = [[UILabel alloc] initWithFrame:CGRectMake(labelunit.frame.origin.x,labelunit.frame.origin.y+labelunit.frame.size.height, imageview.frame.size.width-10, 50)];
	labelstock.font = FONTN(12.0f);
	labelstock.text = [dictemp objectForKey:@"Content"];
	labelstock.numberOfLines = 3;
	labelstock.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelstock];
	

	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//	NSDictionary *dicmessage = [arraydata objectAtIndex:indexPath.row];
//	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//	OnlineComplainDetailViewController *onlinecomp = [storyboard instantiateViewControllerWithIdentifier:@"OnlineComplainDetailViewController"];
//	onlinecomp.strcomid = [dicmessage objectForKey:@"ID"];
//	[self.navigationController pushViewController:onlinecomp animated:YES];
	
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
