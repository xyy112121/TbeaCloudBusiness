//
//  JXStockListViewController.m
//  TeBian
//
//  Created by xyy520 on 15/12/15.
//  Copyright © 2015年 谢 毅. All rights reserved.
//

#import "JXStockListViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "RequestInterface.h"

#import "JQIndicatorView.h"
#import "UIImageView+AFNetworking.h"
#import "AddInterface.h"
#import "JXStockSearchViewController.h"
@interface JXStockListViewController ()

@end

@implementation JXStockListViewController

-(void)returnback:(id)sender
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	JQIndicatorView *indicator = [app.window viewWithTag:IndicatorTag];
	[indicator stopAnimating];
	[self.navigationController popViewControllerAnimated:YES];
}


-(void) requestJXStocklist:(NSString *)comname Page:(NSString *)page Pagesize:(NSString *)pagesize
{

	NSDictionary *parameters = @{@"CommodityName":comname,@"Page": page,@"PageSize":pagesize};
	
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[RequestInterface doGetJsonWithParametersNoAn:parameters App:app RequestCode:@"TBEA09010000" ReqUrl:URLHeader ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *responseObject)
	 {
		 DLog(@"dic====%@",responseObject);
		 arraydata = [responseObject objectForKey:@"KucunList"];
		 if([arraydata count]>0)
		 {
			 self.tableview.delegate = self;
			 self.tableview.dataSource = self;
			 [self.tableview reloadData];
			 [self headerview:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"Totlecount"]]];
		 }
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

-(void)gotosearch:(id)sender
{
    JXStockSearchViewController *stocksearch = [[JXStockSearchViewController alloc] init];
	stocksearch.delegate1 = self;
	[self.navigationController pushViewController:stocksearch animated:YES];
}

-(void)jxsearchstock:(NSString *)sender
{
	strsearchname = sender;
	[self requestJXStocklist:strsearchname Page:@"1" Pagesize:@"10"];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	
	NSDictionary * dict=[NSDictionary dictionaryWithObject:COLORNOW(255, 255, 255) forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dict;
	self.title = @"库存信息";
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
	[buttonright setImage:LOADIMAGE(@"jxsearchicon", @"png") forState:UIControlStateNormal];
	buttonright.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
	[buttonright addTarget:self action: @selector(gotosearch:) forControlEvents: UIControlEventTouchUpInside];
	[contentViewright addSubview:buttonright];
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
	self.navigationItem.rightBarButtonItem = barButtonItemright;
	
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-40)];
    self.tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableview];
    [self setExtraCellLineHidden:self.tableview];
    
//	[self headerview:nil];
	strsearchname = @"";
	[self requestJXStocklist:@"" Page:@"1" Pagesize:@"10"];
    
    
    __weak __typeof(self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        strsearchname = @"";
        [weakSelf requestJXStocklist:@"" Page:@"1" Pagesize:@"10"];
    }];
    
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestJXStocklist:strsearchname Page:@"1" Pagesize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10]];
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
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+5, 15, 55, 20)];
	labeltitle.font = FONTN(12.0f);
	labeltitle.text = @"产品名称:";
	labeltitle.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labeltitle];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x+labeltitle.frame.size.width, 15, 260, 20)];
	labelname.font = FONTN(12.0f);
	labelname.text = [dictemp objectForKey:@"CommodityName"];
	labelname.textColor = COLORNOW(51, 51, 51);
	[cell.contentView addSubview:labelname];
	

	
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x, 40, imageview.frame.size.width, 0.5)];
	imageviewline.backgroundColor = COLORNOW(211, 211, 211);
	[cell.contentView addSubview:imageviewline];
	
	UILabel *labelID = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x,imageviewline.frame.origin.y+5, 110, 20)];
	labelID.font = FONTN(12.0f);
	labelID.text = [NSString stringWithFormat:@"ID:%@",[dictemp objectForKey:@"CommodityCode"]];// @"ID:30234562";
	labelID.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelID];
	
	UILabel *labelunit = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,imageviewline.frame.origin.y+5, 120, 20)];
	labelunit.font = FONTN(12.0f);
	labelunit.text =  [NSString stringWithFormat:@"单位 %@",[dictemp objectForKey:@"UnitofMeasurement"]];// @"单位:KM";
	labelunit.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelunit];
	
	NSString *kucun = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"InventoryNumber"]];
	NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12.0f],NSFontAttributeName, nil];
	
	CGSize size = [kucun boundingRectWithSize:CGSizeMake(300, 25) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
	
	UILabel *labelstocknum = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width-size.width-5,imageviewline.frame.origin.y+5, size.width, 20)];
	labelstocknum.font = FONTN(12.0f);
	labelstocknum.text = kucun;
	labelstocknum.textAlignment = NSTextAlignmentRight;
	labelstocknum.textColor = COLORNOW(255, 102, 0);
	[cell.contentView addSubview:labelstocknum];
	
	UILabel *labelstock = [[UILabel alloc] initWithFrame:CGRectMake(labelstocknum.frame.origin.x-35,imageviewline.frame.origin.y+5, 30, 20)];
	labelstock.font = FONTN(12.0f);
	labelstock.text = @"库存:";
	labelstock.textAlignment = NSTextAlignmentRight;
	labelstock.textColor = COLORNOW(151, 151, 151);
	[cell.contentView addSubview:labelstock];
	
	
	
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
