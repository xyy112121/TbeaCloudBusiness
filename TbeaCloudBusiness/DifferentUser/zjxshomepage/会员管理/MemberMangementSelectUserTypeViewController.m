//
//  MemberMangementSelectUserTypeViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/23.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MemberMangementSelectUserTypeViewController.h"

@interface MemberMangementSelectUserTypeViewController ()

@end

@implementation MemberMangementSelectUserTypeViewController

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
	
	UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
	UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
	[buttonright setTitle:@"保存" forState:UIControlStateNormal];
	[buttonright addTarget:self action: @selector(ClickSaveSelect:) forControlEvents: UIControlEventTouchUpInside];
	[contentViewright addSubview:buttonright];
	buttonright.titleLabel.font = FONTN(15.0f);
	buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
	self.navigationItem.rightBarButtonItem = barButtonItemright;
	
	// Do any additional setup after loading the view.
}

#pragma mark 页面布局

-(void)initview
{
	self.title = @"用户类型";
	self.view.backgroundColor = COLORNOW(235, 235, 235);
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	arrayselect = [[NSMutableArray alloc] init];
	
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight)];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
	
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
-(void)ClickSaveSelect:(id)sender
{
	
}


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
	return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
	return 10;
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
	
	UILabel *lableaddr = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 150, 20)];
	lableaddr.text =@"总经销商";
	lableaddr.font = FONTN(15.0f);
	lableaddr.tag = EnMemberSelectUsertypelabel1;
	lableaddr.textColor = [UIColor blackColor];
	lableaddr.backgroundColor = [UIColor clearColor];
	[cell.contentView addSubview:lableaddr];
	
	UILabel *lablearea = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150, 15, 110, 20)];
	lablearea.text = @"64";
	lablearea.font = FONTMEDIUM(15.0f);
	lablearea.tag = EnMemberSelectUsertypelabel2;
	lablearea.textColor = [UIColor blackColor];
	lablearea.backgroundColor = [UIColor clearColor];
	lablearea.textAlignment = NSTextAlignmentRight;
	[cell.contentView addSubview:lablearea];
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-28, 18, 15, 15)];
	imageview.image = nil;
	imageview.tag = EnMemberSelectUsertypeImageview1;
	[cell.contentView addSubview:imageview];
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	UIImageView *imageview = [cell.contentView viewWithTag:EnMemberSelectUsertypeImageview1];
	imageview.image = LOADIMAGE(@"me默认收货地址", @"png");
	
	UILabel *label1 = [cell.contentView viewWithTag:EnMemberSelectUsertypelabel1];
	UILabel *label2 = [cell.contentView viewWithTag:EnMemberSelectUsertypelabel2];
	label1.textColor = COLORNOW(0, 170, 238);
	label2.textColor = COLORNOW(0, 170, 238);
	
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
