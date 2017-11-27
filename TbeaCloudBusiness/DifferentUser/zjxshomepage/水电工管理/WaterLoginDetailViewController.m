//
//  WaterLoginDetailViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/6/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "WaterLoginDetailViewController.h"

@interface WaterLoginDetailViewController ()

@end

@implementation WaterLoginDetailViewController
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
	
	// Do any additional setup after loading the view.
}

#pragma mark 页面布局

-(void)initview
{
	self.title = @"登录详情";
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationHeight-40)];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
	[self addtabviewheader];
	[self setExtraCellLineHidden:tableview];
}

-(void)addtabviewheader
{
	UIView *tabviewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
	tabviewheader.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tabviewheader];
	[tabviewheader addSubview:[self viewselectitem:CGRectMake(0, 0, SCREEN_WIDTH, 40)]];
}


//表头
-(UIView *)viewselectitem:(CGRect)frame
{
	UIView *viewselectitem = [[UIView alloc] initWithFrame:frame];
	viewselectitem.backgroundColor = [UIColor whiteColor];
	//两根灰线
	UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.7)];
	line1.backgroundColor = COLORNOW(200, 200, 200);
	[viewselectitem addSubview:line1];

	UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.7)];
	line2.backgroundColor = COLORNOW(200, 200, 200);
	[viewselectitem addSubview:line2];
	
	float widthnow = (SCREEN_WIDTH-20)/4;
	
	//会议编号
	ButtonItemLayoutView *buttonitemtime = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, XYViewBottom(line1), widthnow, 40)];
	[buttonitemtime.button addTarget:self action:@selector(ClickSelecttime:) forControlEvents:UIControlEventTouchUpInside];
	buttonitemtime.tag = EnWaterCheckInDetailSelectItembt1;
	[buttonitemtime updatebuttonitem:EnButtonTextCenter TextStr:@"时间" Font:FONTN(14.0f) Color:COLORNOW(0, 170, 236) Image:LOADIMAGE(@"arrowblueunder", @"png")];
	[viewselectitem addSubview:buttonitemtime];
	
	//区域
	ButtonItemLayoutView *buttonitemarea = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow, XYViewBottom(line1), widthnow*2, 40)];
	buttonitemarea.tag = EnWaterCheckInSelectItembt2;
	[buttonitemarea updatebuttonitem:EnButtonTextCenter TextStr:@"定位" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:nil];
	[viewselectitem addSubview:buttonitemarea];
	
	//时间
	ButtonItemLayoutView *buttonitemdevice = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow*3, XYViewBottom(line1), widthnow, 40)];
	buttonitemdevice.tag = EnWaterCheckInSelectItembt3;
	[buttonitemdevice updatebuttonitem:EnButtonTextCenter TextStr:@"设备" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:nil];
	[viewselectitem addSubview:buttonitemdevice];
	
	return viewselectitem;
}


-(void)viewWillAppear:(BOOL)animated
{
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	self.navigationController.navigationBar.translucent = NO;
	[self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
	[self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
	UIColor* color = [UIColor whiteColor];
	NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes= dict;
}

#pragma mark ActionDelegate
-(void)DGSelectDateDone:(NSString *)starttime EndTime:(NSString *)endtime
{
	
}


#pragma mark IBaction
-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)ClickSelecttime:(id)sender
{
	if (flagnow==0)
	{
		flagnow = 1;
		arrayselectitem = @[@"默认排序",@"正序",@"倒序",@"自定义"];
		[self initandydroplist:sender];
		[self.view insertSubview:andydroplist belowSubview:sender];
		[andydroplist showList];
	}
	else
	{
		flagnow = 0;
		[andydroplist hiddenList];
	}
}

#pragma mark TYYNavFilterDelegate
-(AndyDropDownList *)initandydroplist:(UIButton *)button
{
	andydroplist = [[AndyDropDownList alloc] initWithListDataSource:arrayselectitem rowHeight:44 view:button Frame:CGRectMake(0, 41, SCREEN_WIDTH, SCREEN_HEIGHT)];
	andydroplist.delegate = self;
	return andydroplist;
}

-(void)setAndyDropHideflag:(id)sender
{
	flagnow = 0;
}

-(void)dropDownListParame:(NSString *)aStr
{
	flagnow = 0;
	DLog(@"astr====%@",aStr);
	ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnWaterCheckInSelectItembt1];

	if([aStr isEqualToString:@"自定义"])
	{
		TimeSelectViewController *tiemselect = [[TimeSelectViewController alloc] init];
		[self.navigationController pushViewController:tiemselect animated:YES];
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
	return 40;
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
	
	float widthnow = (SCREEN_WIDTH-20)/4;
	NSString *strtiem = @"2017-05-05\n18:55:57";
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, widthnow, 38)];
	labeltime.text = strtiem;
	labeltime.numberOfLines = 2;
	labeltime.textColor = [UIColor blackColor];
	labeltime.font = FONTN(13.0f);
	labeltime.textAlignment = NSTextAlignmentCenter;
	[cell.contentView addSubview:labeltime];
	
	UILabel *labelxinghao = [[UILabel alloc] initWithFrame:CGRectMake(10+widthnow, 6, widthnow*2, 38)];
	labelxinghao.text = @"四川省德阳市旌阳区XX路12号";
	labelxinghao.textColor = [UIColor blackColor];
	labelxinghao.font = FONTN(13.0f);
	labelxinghao.textAlignment = NSTextAlignmentCenter;
	[cell.contentView addSubview:labelxinghao];
	
	UILabel *labeljihuo = [[UILabel alloc] initWithFrame:CGRectMake(10+widthnow*3, 6, widthnow, 38)];
	labeljihuo.text = @"iphone7 plus";
	labeljihuo.textColor = [UIColor blackColor];
	labeljihuo.font = FONTMEDIUM(13.0f);
	labeljihuo.textAlignment = NSTextAlignmentCenter;
	[cell.contentView addSubview:labeljihuo];

	
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

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
