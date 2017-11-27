//
//  SpecificationSelectViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/23.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "SpecificationSelectViewController.h"

@interface SpecificationSelectViewController ()

@end

@implementation SpecificationSelectViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initview];
	
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	button.layer.borderColor = [UIColor clearColor].CGColor;
	[button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
	button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
	[button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;

}

#pragma mark 页面布局

-(void)initview
{
	self.title = @"型号选择";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
	tableview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tableview];
	[self addtabviewheader];
	
	[self getspecificationlist];//获取型号
}

-(void)addtabviewheader
{
	UIView *tabviewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
	tabviewheader.backgroundColor = [UIColor clearColor];
	tableview.tableHeaderView = tabviewheader;
	[tabviewheader addSubview:[self searchbarview]];
}


-(UIView *)searchbarview
{
	UIView *viewsearch = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
	viewsearch.backgroundColor = COLORNOW(0, 170, 238);
	
	SearchTextFieldView *searchtext = [[SearchTextFieldView alloc] initWithFrame:CGRectMake(60, 10, SCREEN_WIDTH-120, 30) Pastr:@"型号查询"];
	searchtext.delegate1 = self;
	[viewsearch addSubview:searchtext];
	
	return viewsearch;
}

#pragma mark IBaction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark tableview delegate
//隐藏那些没有cell的线
-(void)setExtraCellLineHidden: (UITableView *)tableView

{
	UIView *view = [UIView new];
	view.backgroundColor = [UIColor clearColor];
	[tableView setTableFooterView:view];
}

-(void)viewDidLayoutSubviews
{
	if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
		[tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
	}
	
	if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
		[tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
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
	
	return [FCarrayspecifi count];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//	return 40;
//}
//
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//	UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
//	viewheader.backgroundColor = [UIColor whiteColor];
//	viewheader.layer.borderColor = COLORNOW(210, 210, 210).CGColor;
//	viewheader.layer.borderWidth = 0.7;
//	
//	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 30, 30)];
//	labelname.backgroundColor = [UIColor blackColor];
//	labelname.textColor = [UIColor whiteColor];
//	labelname.text = @"A";
//	labelname.layer.cornerRadius = 15.0f;
//	labelname.clipsToBounds = YES;
//	labelname.font = FONTMEDIUM(15.0f);
//	labelname.textAlignment = NSTextAlignmentCenter;
//	[viewheader addSubview:labelname];
//	
//	return viewheader;
//}

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
	
	cell.backgroundColor = [UIColor whiteColor];
	
	NSDictionary *dictemp = [FCarrayspecifi objectAtIndex:indexPath.row];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 20)];
	labelname.backgroundColor = [UIColor clearColor];
	labelname.textColor = COLORNOW(117, 117, 117);
	labelname.font = FONTN(15.0f);
	labelname.tag = EnModelSpecificationCellLabel+indexPath.row+indexPath.section*3;
	labelname.text = [dictemp objectForKey:@"name"];
	[cell.contentView addSubview:labelname];
	if([labelname.text isEqualToString:self.strspecification])
	{
		labelname.textColor = COLORNOW(0, 170, 238);
		UIImageView *imageselect = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40, 15, 14, 10)];
		imageselect.image = LOADIMAGE(@"specificationselected", @"png");
		imageselect.tag = EnModelSpecificationSelectImage;
		[cell.contentView addSubview:imageselect];
	}

	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[[self.view viewWithTag:EnModelSpecificationSelectImage] removeFromSuperview];
	for(int i=0;i<100;i++)
	{
		UILabel *labeltemp = [self.view viewWithTag:EnModelSpecificationCellLabel+i] ;
		labeltemp.textColor = COLORNOW(117, 117, 117);
	}
	
	NSDictionary *dictemp = [FCarrayspecifi objectAtIndex:indexPath.row];
	UITableViewCell *cell = [tableview cellForRowAtIndexPath:indexPath];
	UILabel *label =[cell.contentView viewWithTag:EnModelSpecificationCellLabel+indexPath.row+indexPath.section*3];
	label.textColor = COLORNOW(0, 170, 238);
	
	UIImageView *imageselect = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40, 15, 14, 10)];
	imageselect.image = LOADIMAGE(@"specificationselected", @"png");
	imageselect.tag = EnModelSpecificationSelectImage;
	[cell.contentView addSubview:imageselect];
	
	if([self.delegate1 respondsToSelector:@selector(DGSpecificationSelectInfo:)])
	{
		[self.delegate1 DGSpecificationSelectInfo:dictemp];
	}
	
	[self returnback];
}


#pragma mark 接口
//获取型号
-(void)getspecificationlist
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"commoditycategoryid"] = @"";
	params[@"flag"] = @"1";  //扫码返利的时候表示1
	
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQRebateSpecificationSelect ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			FCarrayspecifi = [[dic objectForKey:@"data"] objectForKey:@"commoditymodellist"];
			tableview.delegate = self;
			tableview.dataSource = self;
			[tableview reloadData];
		}
		else
		{
			[MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		}
	} Failur:^(NSString *strmsg) {
		[MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
		
	}];
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
