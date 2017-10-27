//
//  AreaSelectViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/30.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "AreaSelectViewController.h"

@interface AreaSelectViewController ()

@end

@implementation AreaSelectViewController
- (void)viewDidLoad {
	[super viewDidLoad];
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	
	[self initview];
	
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	button.layer.borderColor = [UIColor clearColor].CGColor;
	[button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
	button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
	[button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	
	UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
	UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
	buttonright.titleLabel.font = FONTN(14.0f);
	buttonright.tag = 900;
	[buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[buttonright setTitle:@"保存" forState:UIControlStateNormal];
	buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
	[buttonright addTarget:self action: @selector(ClickSave:) forControlEvents: UIControlEventTouchUpInside];
	[contentViewright addSubview:buttonright];
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
	self.navigationItem.rightBarButtonItem = barButtonItemright;
	
	// Do any additional setup after loading the view.
}

#pragma mark 页面布局
-(void)initview
{
	self.title = @"区域选择";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	selectarray = [[NSMutableArray alloc] init];
	FCarrayarea = [[NSArray alloc] init];
	
	[self getarealist];
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
	tableview.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
}

//cell布局
-(UIView *)getcellviewarea:(NSDictionary *)sender Frame:(CGRect)frame NowRow:(int)nowrow
{
	UIView *viewcell = [[UIView alloc] initWithFrame:frame];
	viewcell.backgroundColor = [UIColor clearColor];
	float orginx = 20;
	
	UIButton *buttonselectitem = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonselectitem.frame = CGRectMake(0, 0, 50, 50);
	[buttonselectitem setImage:LOADIMAGE(@"menotselectgray", @"png") forState:UIControlStateNormal];
	[buttonselectitem addTarget:self action:@selector(clickselectarea:) forControlEvents:UIControlEventTouchUpInside];
	buttonselectitem.tag = EnAreaSelectCellViewTag+nowrow;
	[viewcell addSubview:buttonselectitem];
	orginx = XYViewWidth(buttonselectitem);
	
	NSString *str = [sender objectForKey:@"name"];
	UILabel *lablename = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(buttonselectitem)+10, 15, 200, 20)];
	lablename.text =str;
	lablename.font = FONTN(15.0f);
	lablename.textColor = [UIColor blackColor];
	lablename.backgroundColor = [UIColor clearColor];
	[viewcell addSubview:lablename];
	
	return viewcell;
}

-(void)viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBar.translucent = NO;
	[self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
	[self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
	UIColor* color = [UIColor whiteColor];
	NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes= dict;
}

#pragma mark IBAction
-(void)ClickSave:(id)sender
{
	if([self.delegate1 respondsToSelector:@selector(DGAreaSelectDone:)])
	{
		[self.delegate1 DGAreaSelectDone:selectarray];
	}
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)clickselectarea:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag]-EnAreaSelectCellViewTag;
	NSDictionary *dictemparea = [FCarrayarea objectAtIndex:tagnow];
	
	int flag = [AddInterface iscontaindic:selectarray DicFrom:dictemparea FlagId:@"id"];
	if(flag == 0)//表示不包含
	{
		[selectarray addObject:dictemparea];
		[button setImage:LOADIMAGE(@"me默认收货地址", @"png") forState:UIControlStateNormal];
	}
	else
	{
		[selectarray removeObject:dictemparea];
		[button setImage:LOADIMAGE(@"menotselectgray", @"png") forState:UIControlStateNormal];
	}
	
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
	return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [FCarrayarea count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 0.001;
	
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	return nil;
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
	
	cell.backgroundColor = [UIColor whiteColor];
	NSDictionary *dictemp = [FCarrayarea objectAtIndex:indexPath.row];
	UIView *viewcell = [self getcellviewarea:dictemp Frame:CGRectMake(0, 0, SCREEN_WIDTH, cell.frame.size.height) NowRow:(int)indexPath.row];
	[cell.contentView addSubview:viewcell];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

#pragma mark 接口
-(void)getarealist
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQAreaListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			FCarrayarea = [[dic objectForKey:@"data"] objectForKey:@"zonelist"];
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
