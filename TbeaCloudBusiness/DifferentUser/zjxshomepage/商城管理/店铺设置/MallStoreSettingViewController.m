//
//  MallStoreSettingViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/7/7.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MallStoreSettingViewController.h"

@interface MallStoreSettingViewController ()

@end

@implementation MallStoreSettingViewController

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
	
	// Do any additional setup after loading the view.
}

#pragma mark 页面布局
-(void)initview
{
	self.title = @"店面设置";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
	[self setExtraCellLineHidden:tableview];
    
    
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
	return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
	static NSString *reuseIdetify = @"cell";
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	for(UIView *view in cell.contentView.subviews)
	{
		[view removeFromSuperview];
	}
	
	cell.backgroundColor = [UIColor whiteColor];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-70, 20)];
	labelname.backgroundColor = [UIColor clearColor];
	labelname.textColor = [UIColor blackColor];
	labelname.font = FONTN(16.0f);
	[cell.contentView addSubview:labelname];
	
	switch (indexPath.row)
	{
		case 0:
			labelname.text = @"形象图";
			
			break;
		case 1:
			labelname.text = @"轮换广告";
			break;
		case 2:
			labelname.text = @"店铺二维码";
            break;
		case 3:
			labelname.text = @"店铺介绍";
			break;
		case 4:
			labelname.text = @"规格型号管理";
			break;
		case 5:
			labelname.text = @"收款帐户";
			break;
	}
	
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	MallStoreTopImageViewController *mallstoretop;
	MallStoreCycleAdViewController *cyclead;
	MallStoreIntrduceViewController *intrduce;
//	SettingCustomViewController *settingcustom;
//    MallStoreSpecialModuleListViewController *spemodulelist;
    MallStoreAddNewSpecialModuleCellViewController *spemodulelist;
	switch (indexPath.row)
	{
		case 0:
			mallstoretop = [[MallStoreTopImageViewController alloc] init];
			[self.navigationController pushViewController:mallstoretop animated:YES];
			break;
		case 1:
			cyclead = [[MallStoreCycleAdViewController alloc] init];
			[self.navigationController pushViewController:cyclead animated:YES];
			break;
		case 3:
			intrduce = [[MallStoreIntrduceViewController alloc] init];
			[self.navigationController pushViewController:intrduce animated:YES];
			break;
		case 4:
			spemodulelist = [[MallStoreAddNewSpecialModuleCellViewController alloc] init];
			[self.navigationController pushViewController:spemodulelist animated:YES];
			break;
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
