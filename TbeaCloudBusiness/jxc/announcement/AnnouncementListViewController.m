//
//  AnnouncementListViewController.m
//  TeBian
//
//  Created by xyy520 on 15/12/16.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import "AnnouncementListViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "RequestInterface.h"

#import "JQIndicatorView.h"
#import "UIImageView+AFNetworking.h"
#import "AddInterface.h"
#import "YTextField.h"
#import "AnnouncementDetailViewController.h"
@interface AnnouncementListViewController ()

@end

@implementation AnnouncementListViewController

-(void)returnback:(id)sender
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	JQIndicatorView *indicator = [app.window viewWithTag:IndicatorTag];
	[indicator stopAnimating];
	[self.navigationController popViewControllerAnimated:YES];
}

//消息列表
-(void) requestJXAnnouncementlist:(NSString *)name Page:(NSString *)page Pagesize:(NSString *)pagesize
{
	
	NSDictionary *parameters = @{@"Name":name,@"Page": page,@"PageSize":pagesize};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA11010000" ReqUrl:URLHeader ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 arraydata = [responseObject objectForKey:@"AnnouncementList"];
		 self.tableview.delegate = self;
		 self.tableview.dataSource = self;
		 [self.tableview reloadData];
         [self.tableview.mj_header endRefreshing];
         [self.tableview.mj_footer endRefreshing];

	 }];
	
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
	[textField resignFirstResponder];
	searchname = @"";
	[self requestJXAnnouncementlist:searchname Page:@"1" Pagesize:@"10"];
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	searchname = textField.text;
	[self requestJXAnnouncementlist:searchname Page:@"1" Pagesize:@"10"];
	return YES;
}



-(void)headerview:(id)sender
{
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
	viewheader.backgroundColor = [UIColor whiteColor];
	
	UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(3, 11, 13, 13)];
	img.image = LOADIMAGE(@"zoomicon", @"png");
	YTextField *textfieldusername = [[YTextField alloc] initWithFrame:CGRectMake(30, 8, SCREEN_WIDTH-60, 35) Icon:img];
	textfieldusername.leftView = img;
	textfieldusername.placeholder = @"";
	textfieldusername.font = FONTLIGHT(14.0f);
	textfieldusername.tag = 101;
	textfieldusername.returnKeyType = UIReturnKeySearch;
	textfieldusername.delegate = self;
	textfieldusername.clearButtonMode = UITextFieldViewModeAlways;
	textfieldusername.backgroundColor = [UIColor clearColor];
	textfieldusername.leftViewMode = UITextFieldViewModeAlways;
	textfieldusername.borderStyle = UITextBorderStyleLine;
	textfieldusername.textAlignment = NSTextAlignmentLeft;//  = UIControlContentVerticalAlignmentCenter;
	textfieldusername.layer.borderColor = COLORNOW(220, 220, 220).CGColor;
	textfieldusername.layer.borderWidth = 1.0f;
	[viewheader addSubview:textfieldusername];
	
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
	self.title = @"公告";
	
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
	searchname = @"";
	[self requestJXAnnouncementlist:searchname Page:@"1" Pagesize:@"10"];
    
    __weak __typeof(self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf requestJXAnnouncementlist:searchname Page:@"1" Pagesize:@"10"];
    }];
    
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestJXAnnouncementlist:searchname Page:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10]];
    }];
	// Do any additional setup after loading the view.
}

#pragma mark - 刷新的代理方法---进入下拉刷新\上拉加载更多都有可能调用这个方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	UITextField *textfield = (UITextField *)[self.tableview.tableHeaderView viewWithTag:101];
	[textfield resignFirstResponder];
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
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+10, 15, 220, 20)];
	labeltitle.font = FONTMEDIUM(12.0f);
	labeltitle.text = [dictemp objectForKey:@"Name"];
	labeltitle.textColor = COLORNOW(51, 51, 51);
	[cell.contentView addSubview:labeltitle];
	
	float nowwidth = 5;
	float fontnow = 8.0f;
	float width1 = 80;
	float width2 = 105;
	if(SCREEN_WIDTH>380)
	{
		width1 = 110;
		width2 = 130;
		nowwidth = 5;
		fontnow = 11.0f;
	}
	else if(SCREEN_WIDTH>370)
	{
		width1 = 100;
		width2 = 120;
		nowwidth = 5;
		fontnow = 10.0f;
	}
	UILabel *labelcode = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x,labeltitle.frame.origin.y+labeltitle.frame.size.height, width1, 15)];
	labelcode.font = FONTN(fontnow);
	labelcode.text = [NSString stringWithFormat:@"编号 %@",[dictemp objectForKey:@"Code"]];
	labelcode.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelcode];

	UILabel *labelstarttime = [[UILabel alloc] initWithFrame:CGRectMake(labelcode.frame.origin.x+labelcode.frame.size.width+nowwidth,labelcode.frame.origin.y, width2, 15)];
	labelstarttime.font = FONTN(fontnow);
	labelstarttime.text = [NSString stringWithFormat:@"发布日期 %@",[dictemp objectForKey:@"PublishDate"]];
	labelstarttime.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelstarttime];
	
//	UILabel *labelendtime = [[UILabel alloc] initWithFrame:CGRectMake(labelstarttime.frame.origin.x+labelstarttime.frame.size.width+nowwidth,labelstarttime.frame.origin.y, width2, 15)];
//	labelendtime.font = FONTN(fontnow);
//	labelendtime.text = [NSString stringWithFormat:@"结束日期 %@",[dictemp objectForKey:@"EndDate"]];
//	labelendtime.textColor = COLORNOW(151, 151, 151);
//	[cell.contentView addSubview:labelendtime];
	
	UILabel *labelsendpersion = [[UILabel alloc] initWithFrame:CGRectMake(labelstarttime.frame.origin.x+labelstarttime.frame.size.width+nowwidth,labelstarttime.frame.origin.y,width2, 15)];
	labelsendpersion.font = FONTN(fontnow);
	labelsendpersion.text = [NSString stringWithFormat:@"发布人 %@",[dictemp objectForKey:@"Author"]];
	labelsendpersion.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelsendpersion];
	
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x, 60, imageview.frame.size.width, 0.5)];
	imageviewline.backgroundColor = COLORNOW(211, 211, 211);
	[cell.contentView addSubview:imageviewline];
	
	UILabel *labelsummary = [[UILabel alloc] initWithFrame:CGRectMake(labelcode.frame.origin.x,imageviewline.frame.origin.y+5, imageview.frame.size.width-20, 50)];
	labelsummary.font = FONTN(12.0f);
	labelsummary.text = [dictemp objectForKey:@"Description"];
	labelsummary.textColor = COLORNOW(151, 151, 151);
	labelsummary.numberOfLines = 2;
	[cell.contentView addSubview:labelsummary];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *dicmessage = [arraydata objectAtIndex:indexPath.row];
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AnnouncementDetailViewController *announcedetail = [[AnnouncementDetailViewController alloc] init];
    
	announcedetail.stranid = [dicmessage objectForKey:@"ID"];
	[self.navigationController pushViewController:announcedetail animated:YES];
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
