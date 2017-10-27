//
//  ContactViewController.m
//  TeBian
//
//  Created by xyy520 on 15/12/19.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import "ContactViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "RequestInterface.h"

#import "JQIndicatorView.h"
#import "UIImageView+AFNetworking.h"
#import "AddInterface.h"
@interface ContactViewController ()

@end

@implementation ContactViewController

-(void)returnback:(id)sender
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	JQIndicatorView *indicator = [app.window viewWithTag:IndicatorTag];
	[indicator stopAnimating];
	[self.navigationController popViewControllerAnimated:YES];
}

//消息列表
-(void) requestJXguidepricelist:(NSString *)statusid Page:(NSString *)page Pagesize:(NSString *)pagesize
{
	
	NSDictionary *parameters = nil;//@{@"ReadStatusId":statusid,@"Page": page,@"PageSize":pagesize};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];

	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA13010000" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 arraydata = [responseObject objectForKey:@"ContactPersonList"];
		 self.tableview.delegate = self;
		 self.tableview.dataSource = self;
		 [self.tableview reloadData];
         [self.tableview.mj_header endRefreshing];
         [self.tableview.mj_footer endRefreshing];
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
	self.title = @"联系我们";
	
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
    
	[self requestJXguidepricelist:nil Page:@"1" Pagesize:@"10"];
	self.tableview.delegate = self;
	self.tableview.dataSource = self;
    
    __weak __typeof(self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestJXguidepricelist:nil Page:@"1" Pagesize:@"10"];
    }];
    
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestJXguidepricelist:nil Page:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10]];
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
	return 110;
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
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 100)];
	imageview.backgroundColor = COLORNOW(252, 252, 252);
	imageview.layer.cornerRadius = 2.0f;
	imageview.clipsToBounds = YES;
	imageview.layer.shadowColor = COLORNOW(42, 42, 42).CGColor;
	imageview.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
	imageview.layer.shadowOpacity = 1.0;//不透明度
	imageview.layer.shadowRadius = 5.0;//半径
	[cell.contentView addSubview:imageview];
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+10, 15, 155, 20)];
	labeltitle.font = FONTN(13.0f);
	labeltitle.text = [dictemp objectForKey:@"Name"];
	labeltitle.textColor = COLORNOW(204, 153, 0);
	[cell.contentView addSubview:labeltitle];
	
	UILabel *labeljobtitle = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+10, 33, 205, 20)];
	labeljobtitle.font = FONTN(12.0f);
	labeljobtitle.text = [dictemp objectForKey:@"JobTitle"];
	labeljobtitle.textColor = COLORNOW(102, 102, 102);
	[cell.contentView addSubview:labeljobtitle];
	
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x, labeljobtitle.frame.origin.y+labeljobtitle.frame.size.height+5, imageview.frame.size.width, 0.5)];
	imageviewline.backgroundColor = COLORNOW(211, 211, 211);
	[cell.contentView addSubview:imageviewline];
	
	UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+10, imageviewline.frame.origin.y+10, 15, 15)];
	imageview1.image = LOADIMAGE(@"contacticon2", @"png");
	[cell.contentView addSubview:imageview1];
	
	UILabel *labelunit = [[UILabel alloc] initWithFrame:CGRectMake(imageview1.frame.origin.x+imageview1.frame.size.width+5,imageview1.frame.origin.y, 120, 15)];
	labelunit.font = FONTN(12.0f);
	labelunit.text =[dictemp objectForKey:@"MobileNumber"];
	labelunit.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelunit];
	
	UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+10, imageview1.frame.origin.y+imageview1.frame.size.height+5, 15, 15)];
	imageview2.image = LOADIMAGE(@"contacticon3", @"png");
	[cell.contentView addSubview:imageview2];
	
	UILabel *labelemail = [[UILabel alloc] initWithFrame:CGRectMake(imageview2.frame.origin.x+imageview2.frame.size.width+5,imageview2.frame.origin.y, 220, 15)];
	labelemail.font = FONTN(12.0f);
	labelemail.text =[dictemp objectForKey:@"EmailAddress"];
	labelemail.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelemail];
	
	UIImageView *imageviewtel = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageviewline.frame.size.width-50, imageviewline.frame.origin.y+10, 25, 25)];
	imageviewtel.image = LOADIMAGE(@"contacticon1", @"png");
	[cell.contentView addSubview:imageviewtel];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *dicmessage = [arraydata objectAtIndex:indexPath.row];
	NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",[dicmessage objectForKey:@"MobileNumber"]];
	UIWebView * callWebview = [[UIWebView alloc] init];
	[callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
	[self.view addSubview:callWebview];
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
