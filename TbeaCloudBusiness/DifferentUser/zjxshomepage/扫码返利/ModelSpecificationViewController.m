//
//  ModelSpecificationViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/23.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ModelSpecificationViewController.h"

@interface ModelSpecificationViewController ()

@end

@implementation ModelSpecificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	button.layer.borderColor = [UIColor clearColor].CGColor;
	[button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
	button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
	[button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	
	[self initview];
    // Do any additional setup after loading the view.
}

#pragma mark 页面布局
-(void)initview
{
	self.title = @"型号规格";
	self.view.backgroundColor = [UIColor whiteColor];
	strmodel = @"";
	strspecification = @"";
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

#pragma mark Actiondelegate
-(void)DGModelSelectInfo:(NSDictionary *)sender
{
	strmodel = [sender objectForKey:@"name"];
	strmodelid = [sender objectForKey:@"id"];
	UILabel *label1 = [self.view viewWithTag:EnModelSpecificationLabel1];
	UILabel *label3 = [self.view viewWithTag:EnModelSpecificationLabel3];
	label3.text = strmodel;
	label1.text = [NSString stringWithFormat:@"%@ %@",strspecification,strmodel];
}

-(void)DGSpecificationSelectInfo:(NSDictionary *)sender
{
	strspecification = [sender objectForKey:@"name"];
	strspecificationid = [sender objectForKey:@"id"];
	UILabel *label1 = [self.view viewWithTag:EnModelSpecificationLabel1];
	UILabel *label2 = [self.view viewWithTag:EnModelSpecificationLabel2];
	label2.text = strspecification;
	label1.text = [NSString stringWithFormat:@"%@ %@",strspecification,strmodel];
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
	
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
	static NSString *reuseIdetify = @"cell";
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
	for(UIView *view in cell.contentView.subviews)
	{
		[view removeFromSuperview];
	}
	
	cell.backgroundColor = [UIColor whiteColor];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 20)];
	labelname.backgroundColor = [UIColor clearColor];
	labelname.textColor = COLORNOW(117, 117, 117);
	
	
	UILabel *labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(labelname)+10, 5, 200, 30)];
	labelvalue.backgroundColor = [UIColor clearColor];
	labelvalue.textColor = COLORNOW(117, 117, 117);
	labelvalue.font = FONTN(15.0f);
	switch (indexPath.row)
	{
		case 0:
			cell.accessoryType = UITableViewCellAccessoryNone;
			labelname.text = @"已选择";
			labelname.font = FONTMEDIUM(16.0f);
			labelname.textColor = [UIColor blackColor];
			[cell.contentView addSubview:labelname];
			
			labelvalue.textColor = [UIColor blackColor];
			labelvalue.tag = EnModelSpecificationLabel1;
			labelvalue.text = [NSString stringWithFormat:@"%@%@",strspecification,strmodel];
			[cell.contentView addSubview:labelvalue];
			break;
		case 1:
			labelname.text = @"型号";
			labelname.font = FONTN(15.0f);
			[cell.contentView addSubview:labelname];
			
			labelvalue.textColor = [UIColor blackColor];
			labelvalue.tag = EnModelSpecificationLabel2;
			[cell.contentView addSubview:labelvalue];
			break;
		case 2:
			labelname.text = @"规格";
			labelname.font = FONTN(15.0f);
			[cell.contentView addSubview:labelname];
			
			labelvalue.textColor = [UIColor blackColor];
			labelvalue.tag = EnModelSpecificationLabel3;
			[cell.contentView addSubview:labelvalue];
			break;

	}

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableview cellForRowAtIndexPath:indexPath];
	if(indexPath.row==1)
	{
		SpecificationSelectViewController *specification = [[SpecificationSelectViewController alloc] init];
		specification.delegate1 = self;
		specification.strspecification = [[cell.contentView viewWithTag:EnModelSpecificationLabel2] text];
		[self.navigationController pushViewController:specification animated:YES];
	}
	else if(indexPath.row == 2)
	{
		ModelSelectViewController *modelselect = [[ModelSelectViewController alloc] init];
		modelselect.delegate1 = self;
		modelselect.strmodel = [[cell.contentView viewWithTag:EnModelSpecificationLabel3] text];
		[self.navigationController pushViewController:modelselect animated:YES];
	}
}



#pragma mark IBaction
-(void)returnback
{
	UILabel *label1 = [self.view viewWithTag:EnModelSpecificationLabel1];
	if([self.delegate1 respondsToSelector:@selector(DGProductSpecification:Speid:Modelid:)])
	{
		[self.delegate1 DGProductSpecification:label1.text Speid:strspecificationid Modelid:strmodelid];
	}
	
	[self.navigationController popViewControllerAnimated:YES];
}




#pragma mark 接口



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
