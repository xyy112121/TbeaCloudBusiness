//
//  InstitutionViewController.m
//  TeBian
//
//  Created by xyy520 on 15/12/17.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import "InstitutionViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "RequestInterface.h"

#import "JQIndicatorView.h"
#import "UIImageView+AFNetworking.h"
#import "AddInterface.h"
#import "InsWebViewController.h"
@interface InstitutionViewController ()

@end

@implementation InstitutionViewController

-(void)returnback:(id)sender
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	JQIndicatorView *indicator = [app.window viewWithTag:IndicatorTag];
	[indicator stopAnimating];
	[self.navigationController popViewControllerAnimated:YES];
}

-(void) requestJXInstitutionlist:(NSString *)categoryid Page:(NSString *)page Pagesize:(NSString *)pagesize
{
	
	
	NSDictionary *parameters = @{@"RuleCategoryId":categoryid,@"Page": page,@"PageSize":pagesize};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA12020000" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 arraydata = [responseObject objectForKey:@"RuleList"];
		 self.tableview.delegate = self;
		 self.tableview.dataSource = self;
		 [self.tableview reloadData];
		 

         [self.tableview.mj_header endRefreshing];
         [self.tableview.mj_footer endRefreshing];
	 }];
	
}

-(void) requestJXCategorylist
{

	
	NSDictionary *parameters = nil;// @{@"ReadStatusId":statusid,@"Page": page,@"PageSize":pagesize};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA12010000" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 arraydatacategory = [responseObject objectForKey:@"RuleCategoryList"];
		 
		 if([arraydatacategory count]>0)
		 {
			 [self headerview:arraydatacategory];
			 NSDictionary *dictemp = [arraydatacategory objectAtIndex:0];
			 strcategoryid = [dictemp objectForKey:@"ID"];
			 if(strcategoryid!=nil)
			 {
                 __weak __typeof(self) weakSelf = self;
                 self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                     if(strcategoryid!=nil)
                         [weakSelf requestJXInstitutionlist:strcategoryid Page:@"1" Pagesize:@"10"];
                 }];
                 
                 self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                     if(strcategoryid!=nil)
                         [weakSelf requestJXInstitutionlist:strcategoryid Page:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10]];
                 }];
                 
				 [self requestJXInstitutionlist:strcategoryid Page:@"1" Pagesize:@"10"];
			 }
		 }
         [self.tableview.mj_header endRefreshing];
         [self.tableview.mj_footer endRefreshing];
	 }];
	
}

-(void)headerview:(NSArray *)sender
{
	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
	viewheader.backgroundColor = [UIColor whiteColor];
	
	int nowwidth = 0;
	for(int i=0;i<[sender count];i++)
	{
		NSDictionary *dictemp = [sender objectAtIndex:i];
		CGSize size = [AddInterface getlablesize:[dictemp objectForKey:@"Name"] Fwidth:200 Fheight:40 Sfont:FONTN(15.0f)];
		
		UIButton *buttonxiadan = [UIButton buttonWithType:UIButtonTypeCustom];
		buttonxiadan.frame = CGRectMake(nowwidth, 0, size.width+20,40);
		buttonxiadan.titleLabel.font = FONTMEDIUM(14.0f);
		[buttonxiadan setBackgroundColor:[UIColor clearColor]];
		[buttonxiadan setTitleColor:COLORNOW(151, 151, 151) forState:UIControlStateNormal];
		buttonxiadan.tag = 1020+i;
		[buttonxiadan setTitle:[dictemp objectForKey:@"Name"] forState:UIControlStateNormal];
		[buttonxiadan addTarget:self action:@selector(clickcategory:) forControlEvents:UIControlEventTouchUpInside];
		[viewheader addSubview:buttonxiadan];
		
		UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(buttonxiadan.frame.origin.x, buttonxiadan.frame.origin.y+buttonxiadan.frame.size.height-2, buttonxiadan.frame.size.width,2)];
		imageview.backgroundColor = COLORNOW(23, 69, 146);
		imageview.alpha = 0;
		imageview.tag = 1120+i;
		if(i==0)
		{
			imageview.alpha = 1;
			[buttonxiadan setTitleColor:COLORNOW(72, 72, 72) forState:UIControlStateNormal];
		}
		[viewheader addSubview:imageview];
		
		nowwidth = buttonxiadan.frame.origin.x+buttonxiadan.frame.size.width;
	}
	
	self.tableview.tableHeaderView = viewheader;
}

-(void)clickcategory:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag]-1020;
	for(int i=0;i<[arraydatacategory count];i++)
	{
		UIButton *buttontemp = [self.tableview.tableHeaderView viewWithTag:1020+i];
		[buttontemp setTitleColor:COLORNOW(151, 151, 151) forState:UIControlStateNormal];
		UIImageView *imageviewtemp = [self.tableview.tableHeaderView viewWithTag:1120+i];
		imageviewtemp.alpha = 0;
	}
	
	[button setTitleColor:COLORNOW(72, 72, 72) forState:UIControlStateNormal];
	UIImageView *imageviewtemp = [self.tableview.tableHeaderView viewWithTag:1120+tagnow];
	imageviewtemp.alpha = 1;
	NSDictionary *dictemp = [arraydatacategory objectAtIndex:tagnow];
	strcategoryid = [dictemp objectForKey:@"ID"];
	[self requestJXInstitutionlist:strcategoryid Page:@"1" Pagesize:@"10"];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"制度";
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
    
	[self requestJXCategorylist];
	
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
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 60)];
	imageview.backgroundColor = COLORNOW(252, 252, 252);
	imageview.layer.cornerRadius = 2.0f;
	imageview.clipsToBounds = YES;
	imageview.layer.shadowColor = COLORNOW(42, 42, 42).CGColor;
	imageview.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
	imageview.layer.shadowOpacity = 1.0;//不透明度
	imageview.layer.shadowRadius = 5.0;//半径
	[cell.contentView addSubview:imageview];
	
	
	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
	
	UIImageView *imageviewicon = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+10, 15, 15, 15)];
	NSURL *urlstr = [NSURL URLWithString:[URLPicHeader stringByAppendingString:[dictemp objectForKey:@"DocumentTypeIcon"]]];
	[imageviewicon setImageWithURL:urlstr placeholderImage:LOADIMAGE(@"wordicon", @"png")];
	[cell.contentView addSubview:imageviewicon];
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(imageviewicon.frame.origin.x+imageviewicon.frame.size.width+5, 15, SCREEN_WIDTH-110, 20)];
	labeltitle.font = FONTN(13.0f);
	labeltitle.text = [dictemp objectForKey:@"Name"];
	labeltitle.textColor = COLORNOW(72, 72, 72);
	[cell.contentView addSubview:labeltitle];
	
	UIImageView *imageviewicon1 = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-57, 21, 7, 8)];
	[imageviewicon1 setImageWithURL:urlstr placeholderImage:LOADIMAGE(@"affixicon", @"png")];
	[cell.contentView addSubview:imageviewicon1];
	
	UILabel *labelsize = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-48, 15, 45, 20)];
	labelsize.font = FONTN(11.0f);
	labelsize.textAlignment = NSTextAlignmentRight;
	labelsize.text = [dictemp objectForKey:@"DocumentSize"];
	labelsize.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelsize];
	
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x, 40, imageview.frame.size.width, 0.5)];
	imageviewline.backgroundColor = COLORNOW(211, 211, 211);
	[cell.contentView addSubview:imageviewline];
	
	UILabel *labelcategory = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+10, imageviewline.frame.origin.y+5, 30, 20)];
	labelcategory.font = FONTN(11.0f);
	labelcategory.text = @"类别";
	labelcategory.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelcategory];
	
	UILabel *labelcategoryname = [[UILabel alloc] initWithFrame:CGRectMake(labelcategory.frame.origin.x+labelcategory.frame.size.width,labelcategory.frame.origin.y, 150, 20)];
	labelcategoryname.font = FONTN(11.0f);
	labelcategoryname.text = [dictemp objectForKey:@"RuleCategory"];
	labelcategoryname.textColor = COLORNOW(51, 51, 51);
	[cell.contentView addSubview:labelcategoryname];
	
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-140,labelcategory.frame.origin.y, 135, 20)];
	labeltime.font = FONTN(11.0f);
	labeltime.text = [NSString stringWithFormat:@"创建日期 %@",[dictemp objectForKey:@"Date"]];
	labeltime.textColor = COLORNOW(151, 151, 151);
	labeltime.textAlignment = NSTextAlignmentRight;
	[cell.contentView addSubview:labeltime];
	

	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *dicmessage = [arraydata objectAtIndex:indexPath.row];
    InsWebViewController *inswebview = [[InsWebViewController alloc] init];
    
	inswebview.strattachment = [URLPicHeader stringByAppendingString:[dicmessage objectForKey:@"Attachment"]];
	inswebview.strtitle = [dicmessage objectForKey:@"Name"];
	[self.navigationController pushViewController:inswebview animated:YES];
	
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
